-- Headless integration spec: the filetype menu against the real which-key.
--
-- Drives the real production chain — domain map -> usecase -> adapter ->
-- which-key — so a regression anywhere in it fails this spec. Only the
-- controller registry is stubbed, because controllers are covered by
-- tests/filetype_menu_controller_spec.lua and resolving them here would pull in
-- every plugin in the config.
--
-- No filetype ships a menu today, so the spec registers two fixture menus: what
-- is under test is the mechanism, not which filetypes happen to opt in.
--
--   nvim --headless -u NONE -c "luafile tests/filetype_menu_integration_spec.lua" -c "qa!"
package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path

local wk_path = vim.fn.expand("~/.local/share/nvim/lazy/which-key.nvim")
if vim.fn.isdirectory(wk_path) == 0 then
  print("SKIP - which-key.nvim is not installed at " .. wk_path)
  return
end
vim.opt.runtimepath:append(wk_path)
vim.g.mapleader = " "

local failures = 0
local function check(label, cond, extra)
  print((cond and "ok   - " or "FAIL - ") .. label .. (extra and ("  [" .. tostring(extra) .. "]") or ""))
  if not cond then
    failures = failures + 1
  end
end

local wk = require("which-key")
wk.setup({})

-- setup() defers load to VimEnter, which has not fired under `-c luafile`.
vim.cmd("doautocmd VimEnter")
vim.wait(2000, function()
  return require("which-key.config").loaded
end)
check("which-key loaded", require("which-key.config").loaded)

-- Stand in for the real config's global leader binds.
wk.add({ { "<leader>ff", function() end, desc = "Find file" } })

package.loaded["application.usecases.logger"] =
  { debug = function() end, info = function() end, warn = function() end, error = function() end, log = function() end }

-- Every controller resolves to a stub returning ControllerActions.
local generic = setmetatable({}, {
  __index = function()
    return function()
      return function() end
    end
  end,
})
package.loaded["domain.contracts.controller_registry"] = setmetatable({}, {
  __index = function()
    return function()
      return generic
    end
  end,
})

-- The real adapter, pointed at the real which-key.
package.loaded["infrastructure.plugins.plugin_registry"] = setmetatable({}, {
  __index = function()
    return function()
      return { which_key = wk, hydra = function() end }
    end
  end,
})
local adapter = require("infrastructure.adapters.keymapper")
package.loaded["application.ports.adapter_registry"] = setmetatable({}, {
  __index = function()
    return function()
      return adapter
    end
  end,
})

local usecase = require("application.usecases.keymapper")
local filetypes = require("domain.maps.filetypes")

-- Fixture menus: `spec_beta` carries a nested group, `spec_alpha` does not.
filetypes.menus.spec_alpha = function()
  return {
    { key = "s", description = "Status", method = function() end },
    { key = "b", description = "Blame", method = function() end },
  }
end
filetypes.menus.spec_beta = function()
  return {
    { key = "c", description = "Comment" },
    { key = "ca", description = "Add", method = function() end },
    { key = "o", description = "Browse", method = function() end },
  }
end

-- Register the menu exactly the way the FileType hook does.
local ft_buf = vim.api.nvim_create_buf(true, false)
vim.api.nvim_set_current_buf(ft_buf)
vim.bo[ft_buf].filetype = "spec_alpha"
usecase.register_filetype("spec_alpha")

local function bufmap(buf, lhs)
  local out
  vim.api.nvim_buf_call(buf, function()
    out = vim.fn.maparg(lhs, "n", false, true)
  end)
  return out
end

-- 1. The redirect is a real buffer-local mapping, and which-key did not replace it.
local leader = bufmap(ft_buf, " ")
check("buffer-local <leader> mapping exists", leader ~= nil and not vim.tbl_isempty(leader))
check("buffer-local <leader> carries nowait", leader and leader.nowait == 1, leader and leader.nowait)
check("which-key did not replace it with a trigger", leader and leader.desc == "Filetype menu", leader and leader.desc)

-- 2. The menu keys are real buffer-local mappings, and they are NOT nowait:
--    only the redirect may fire before Vim resolves a longer sequence.
local menu = filetypes.menus.spec_alpha()
local missing, wrong_nowait, wrong_desc = {}, {}, {}
for _, bind in ipairs(menu) do
  if bind.method == nil then
    goto continue
  end
  local mapped = bufmap(ft_buf, filetypes.root .. bind.key)
  if not mapped or vim.tbl_isempty(mapped) then
    missing[#missing + 1] = bind.key
  else
    if mapped.nowait ~= 0 then
      wrong_nowait[#wrong_nowait + 1] = bind.key
    end
    if mapped.desc ~= bind.description then
      wrong_desc[#wrong_desc + 1] = bind.key
    end
  end
  ::continue::
end
check("every menu bind became a buffer-local mapping", #missing == 0, table.concat(missing, ","))
check("no menu bind is nowait", #wrong_nowait == 0, table.concat(wrong_nowait, ","))
check("every menu bind keeps its description", #wrong_desc == 0, table.concat(wrong_desc, ","))

-- 3. The tree resolves the menu root from the literal prefix string.
local Buf = require("which-key.buf")
local mode = Buf.get({ mode = "n", buf = ft_buf, update = true })
check("which-key built a mode for the filetype buffer", mode ~= nil)
if mode then
  local node = mode.tree:find(filetypes.root, { expand = true })
  check("tree resolves the menu root", node ~= nil)
  if node then
    check(
      "menu node has one child per bind",
      vim.tbl_count(node._children or {}) == #menu,
      vim.tbl_count(node._children or {})
    )
  end
end

-- 4. A nested group: <leader> c a must reach a real mapping, and the
--    intermediate `c` must render as a labelled group rather than a bare prefix.
local beta_buf = vim.api.nvim_create_buf(true, false)
vim.api.nvim_set_current_buf(beta_buf)
vim.bo[beta_buf].filetype = "spec_beta"
usecase.register_filetype("spec_beta")

local ca = bufmap(beta_buf, filetypes.root .. "ca")
check("spec_beta " .. filetypes.root .. "ca is a real buffer-local mapping", ca ~= nil and not vim.tbl_isempty(ca))
check("spec_beta ca keeps its description", ca and ca.desc == "Add", ca and ca.desc)
check("the bare group prefix c is not itself mapped", vim.tbl_isempty(bufmap(beta_buf, filetypes.root .. "c") or {}))

local beta_mode = Buf.get({ mode = "n", buf = beta_buf, update = true })
check("which-key built a mode for the spec_beta buffer", beta_mode ~= nil)
if beta_mode then
  local group = beta_mode.tree:find(filetypes.root .. "c", { expand = true })
  check("tree resolves the c group", group ~= nil)
  -- A group has no real keymap; which-key keeps its label on `node.mapping`.
  check(
    "c group is labelled Comment",
    group and group.mapping and group.mapping.desc == "Comment",
    group and group.mapping and group.mapping.desc
  )
  check("c group contains a", group and group._children and group._children["a"] ~= nil)
end

-- Group labels must be buffer-scoped like every other bind. Every filetype menu
-- shares one root, so a globally-registered group leaks across filetypes.
local alpha_mode = Buf.get({ mode = "n", buf = ft_buf, update = true })
check("which-key still has a mode for the spec_alpha buffer", alpha_mode ~= nil)
if alpha_mode then
  check(
    "spec_beta's c group did not leak into the spec_alpha menu",
    alpha_mode.tree:find(filetypes.root .. "c", { expand = true }) == nil
  )
end

-- 5. A normal buffer is untouched: no redirect, no menu, global menu intact.
local normal_buf = vim.api.nvim_create_buf(true, false)
vim.api.nvim_set_current_buf(normal_buf)
vim.bo[normal_buf].filetype = "lua"
usecase.register_filetype("lua")

local normal_leader = bufmap(normal_buf, " ")
check(
  "normal buffer has no redirect mapping",
  not normal_leader or vim.tbl_isempty(normal_leader) or normal_leader.desc ~= "Filetype menu",
  normal_leader and normal_leader.desc
)

local normal_mode = Buf.get({ mode = "n", buf = normal_buf, update = true })
check("which-key built a mode for the normal buffer", normal_mode ~= nil)
if normal_mode then
  check("normal buffer has no menu tree", normal_mode.tree:find(filetypes.root, { expand = true }) == nil)
  local leader_node = normal_mode.tree:find("<leader>", { expand = true })
  check(
    "normal buffer still resolves the global <leader>f",
    leader_node ~= nil and leader_node._children ~= nil and leader_node._children["f"] ~= nil
  )
end

if failures > 0 then
  vim.cmd("cq")
end
