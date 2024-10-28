-- Headless wiring spec: unprefixed map -> controller -> usecase -> port spy.
--   nvim --headless -u NONE -c "luafile tests/window_scroll_next_wiring_spec.lua" -c "qa!"
package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path

package.loaded["application.usecases.logger"] =
  { debug = function() end, info = function() end, warn = function() end, error = function() end, log = function() end }

-- Spy adapter captures the direction passed to scroll.
local captured = {}
package.loaded["application.ports.adapter_registry"] = setmetatable({}, {
  __index = function()
    return function()
      return {
        scroll = function(direction)
          captured[#captured + 1] = direction
        end,
      }
    end
  end,
})

-- Real usecase reads the spy adapter above.
local usecase = require("application.usecases.window")
package.loaded["application.ports.usecase_registry"] = setmetatable({}, {
  __index = function(_, k)
    if k == "window" then
      return function()
        return usecase
      end
    end
    return function()
      return {}
    end
  end,
})

-- Real controller reads the usecase registry above.
local controller = require("presentation.controllers.window")

-- Controller registry: real window controller, generic stubs for everything else the map loads.
local generic = setmetatable({}, {
  __index = function()
    return function()
      return function() end
    end
  end,
})
package.loaded["domain.contracts.controller_registry"] = setmetatable({}, {
  __index = function(_, k)
    if k == "window" then
      return function()
        return controller
      end
    end
    return function()
      return generic
    end
  end,
})

local binds = require("domain.maps.unprefixed")()

local failures = 0
local function check(label, cond)
  print((cond and "ok   - " or "FAIL - ") .. label)
  if not cond then
    failures = failures + 1
  end
end

local function find(key)
  for _, bind in ipairs(binds) do
    if bind.key == key then
      return bind
    end
  end
end

local function has_mode(bind, mode)
  local modes = bind and bind.mode or {}
  if type(modes) == "string" then
    modes = { modes }
  end
  for _, m in ipairs(modes) do
    if m == mode then
      return true
    end
  end
  return false
end

for _, case in ipairs({ { "<C-A-v>", "down" }, { "<C-A-S-v>", "up" } }) do
  local key = case[1]
  local bind = find(key)
  check("bind " .. key .. " exists with a callable method", bind ~= nil and type(bind.method) == "function")
  check("bind " .. key .. " is mapped in normal mode", has_mode(bind, "n"))
  check("bind " .. key .. " is mapped in visual mode", has_mode(bind, "v"))
  if bind and type(bind.method) == "function" then
    bind.method()
  end
end

check("adapter received directions down, up in order", #captured == 2 and captured[1] == "down" and captured[2] == "up")

-- The ambiguous notation must never appear: <C-A-V> collapses onto <C-A-v>.
check("no bind uses the ambiguous <C-A-V> notation", find("<C-A-V>") == nil)

if failures > 0 then
  vim.cmd("cq")
end
