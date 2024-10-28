-- Headless spec: register_filetype builds buffer-local binds and hands them to the adapter.
--   nvim --headless -u NONE -c "luafile tests/filetype_menu_usecase_spec.lua" -c "qa!"
package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path

package.loaded["application.usecases.logger"] =
  { debug = function() end, info = function() end, warn = function() end, error = function() end, log = function() end }

-- Spy adapter captures each register_all payload.
local registered = {}
package.loaded["application.ports.adapter_registry"] = setmetatable({}, {
  __index = function()
    return function()
      return {
        register_all = function(maps)
          registered[#registered + 1] = maps
        end,
        format = function(m)
          return m
        end,
        register = function() end,
        show = function() end,
        create_transient = function() end,
        set = function() end,
        unset = function() end,
      }
    end
  end,
})

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

local usecase = require("application.usecases.keymapper")
local filetypes = require("domain.maps.filetypes")

-- No filetype ships a menu today, so the spec registers its own: what is under
-- test is the mechanism, not which filetypes happen to opt in. `spec_beta`
-- carries a nested group so group labels stay covered.
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

local failures = 0
local function check(label, cond)
  print((cond and "ok   - " or "FAIL - ") .. label)
  if not cond then
    failures = failures + 1
  end
end

check("register_filetype exists", type(usecase.register_filetype) == "function")

-- An unmapped filetype registers nothing at all.
usecase.register_filetype("lua")
check("unmapped filetype registers nothing", #registered == 0)

-- A mapped filetype registers exactly one batch.
usecase.register_filetype("spec_alpha")
check("mapped filetype registers one batch", #registered == 1)

local binds = registered[1] or {}
local menu = filetypes.menus.spec_alpha()
check("batch holds the redirect plus every menu bind", #binds == #menu + 1)

local redirect = binds[1]
check("redirect comes first", redirect and redirect.key == "<leader>")
check("redirect is buffer-local", redirect and redirect.buffer == 0)
check("redirect keeps nowait", redirect and redirect.nowait == true)
check("redirect is silent", redirect and redirect.silent == true)
check("redirect is noremap", redirect and redirect.noremap == true)
check("redirect has a callable method", redirect and type(redirect.method) == "function")

-- Every menu bind is prefixed, buffer-local, and NOT nowait.
local expected = {}
for _, bind in ipairs(menu) do
  expected[filetypes.root .. bind.key] = bind.description
end

local ok_prefix, ok_buffer, ok_nowait, ok_mode, ok_desc = true, true, true, true, true
for i = 2, #binds do
  local bind = binds[i]
  if bind.key:sub(1, #filetypes.root) ~= filetypes.root then
    ok_prefix = false
  end
  if bind.buffer ~= 0 then
    ok_buffer = false
  end
  if bind.nowait ~= false then
    ok_nowait = false
  end
  if bind.mode ~= "n" then
    ok_mode = false
  end
  if expected[bind.key] ~= bind.description then
    ok_desc = false
  end
end

check("every menu bind is prefixed with the root", ok_prefix)
check("every menu bind is buffer-local", ok_buffer)
check("menu binds do not set nowait", ok_nowait)
check("menu binds default to normal mode", ok_mode)
check("menu bind descriptions survive prefixing", ok_desc)

-- The domain map must not be mutated: prefixing works on a clone.
local again = filetypes.menus.spec_alpha()
local unprefixed = true
for _, bind in ipairs(again) do
  if bind.key:sub(1, #filetypes.root) == filetypes.root then
    unprefixed = false
  end
end
check("the domain menu is not mutated by registration", unprefixed)

-- A second filetype registers its own menu, group labels included.
usecase.register_filetype("spec_beta")
check("a second filetype registers its own batch", #registered == 2)
check("its batch is sized by its own menu", #(registered[2] or {}) == #filetypes.menus.spec_beta() + 1)

local group
for _, bind in ipairs(registered[2] or {}) do
  if bind.key == filetypes.root .. "c" then
    group = bind
  end
end
check("group labels are registered too", group ~= nil)
check("group labels stay method-less", group and group.method == nil)
check("group labels are buffer-local", group and group.buffer == 0)

if failures > 0 then
  vim.cmd("cq")
end
