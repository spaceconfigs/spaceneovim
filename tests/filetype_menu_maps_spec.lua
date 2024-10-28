-- Headless spec: per-filetype menu maps are well-formed pure data.
--   nvim --headless -u NONE -c "luafile tests/filetype_menu_maps_spec.lua" -c "qa!"
package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path

-- Every controller resolves to a stub whose every method returns a ControllerAction.
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

local failures = 0
local function check(label, cond)
  print((cond and "ok   - " or "FAIL - ") .. label)
  if not cond then
    failures = failures + 1
  end
end

local filetypes = require("domain.maps.filetypes")

check("root is the reserved <F13> prefix", filetypes.root == "<F13>")
check("menus is a table", type(filetypes.menus) == "table")

-- No filetype overrides the global menu today; the mechanism stays available.
check("no filetype claims the leader menu by default", next(filetypes.menus) == nil)

-- Ordinary buffers must never pick up a menu, whatever gets registered later.
for _, ft in ipairs({ "lua", "gitcommit", "gitrebase", "markdown" }) do
  check("filetype " .. ft .. " has no menu", filetypes.menus[ft] == nil)
end

-- Whatever menus a future map registers must satisfy the shape the use case
-- assumes. Vacuous while `menus` is empty; the guard is the point.
local seen_menus = {}
for ft, menu in pairs(filetypes.menus) do
  check(ft .. " maps to a menu function", type(menu) == "function")
  if type(menu) == "function" and not seen_menus[menu] then
    seen_menus[menu] = true
    local binds = menu()
    check(ft .. " menu returns a non-empty list", type(binds) == "table" and #binds > 0)

    local keys, groups = {}, {}
    for _, bind in ipairs(binds) do
      -- A bind with no method is a group label (which-key renders it as a prefix).
      check(
        ft .. " bind " .. tostring(bind.key) .. " is an action or a group",
        bind.method == nil or type(bind.method) == "function"
      )
      check(ft .. " bind " .. tostring(bind.key) .. " has a description", type(bind.description) == "string")
      check(
        ft .. " bind " .. tostring(bind.key) .. " is not pre-prefixed",
        bind.key:sub(1, #filetypes.root) ~= filetypes.root
      )
      check(ft .. " bind " .. tostring(bind.key) .. " is unique", keys[bind.key] == nil)
      keys[bind.key] = true
      if bind.method == nil then
        groups[bind.key] = true
      end
    end

    -- Nested groups: every multi-key bind needs its prefix declared as a group,
    -- otherwise which-key renders the prefix with no label.
    for _, bind in ipairs(binds) do
      if bind.method ~= nil and #bind.key > 1 and bind.key:sub(1, 1) ~= "<" then
        check(ft .. " prefix of " .. bind.key .. " is declared as a group", groups[bind.key:sub(1, 1)] == true)
      end
    end
  end
end

-- The redirect is the bind that replaces the global menu.
local redirect = filetypes.redirect()
check("redirect is bound to <leader>", redirect.key == "<leader>")
check("redirect sets nowait", redirect.nowait == true)
check("redirect has a callable method", type(redirect.method) == "function")
check("redirect is normal mode", redirect.mode == "n")
check("redirect has a description", type(redirect.description) == "string")

-- redirect() must return a fresh table each call; the use case mutates it.
local a, b = filetypes.redirect(), filetypes.redirect()
check("redirect returns a fresh table each call", a ~= b)

if failures > 0 then
  vim.cmd("cq")
end
