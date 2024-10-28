-- Headless wiring spec: map -> controller -> usecase -> port spy.
--   nvim --headless -u NONE -c "luafile tests/window_layout_wiring_spec.lua" -c "qa!"
package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path

package.loaded["application.usecases.logger"] =
  { debug = function() end, info = function() end, warn = function() end, error = function() end, log = function() end }

-- Spy adapter captures the count passed to layout.
local captured = {}
package.loaded["application.ports.adapter_registry"] = setmetatable({}, {
  __index = function()
    return function()
      return { layout = function(opts) captured[#captured + 1] = opts.count end }
    end
  end,
})

-- Real usecase reads the spy adapter above.
local usecase = require("application.usecases.window")
package.loaded["application.ports.usecase_registry"] = setmetatable({}, {
  __index = function(_, k)
    if k == "window" then return function() return usecase end end
    return function() return {} end
  end,
})

-- Real controller reads the usecase registry above.
local controller = require("presentation.controllers.window")

-- Controller registry: real window controller, generic stubs for the rest the map loads.
local generic = setmetatable({}, { __index = function() return function() return function() end end end })
package.loaded["domain.contracts.controller_registry"] = setmetatable({}, {
  __index = function(_, k)
    if k == "window" then return function() return controller end end
    return function() return generic end
  end,
})

local binds = require("domain.maps.window")()

local failures = 0
local function check(label, cond)
  print((cond and "ok   - " or "FAIL - ") .. label)
  if not cond then failures = failures + 1 end
end

local function find(key)
  for _, b in ipairs(binds) do
    if b.key == key then return b end
  end
end

for _, n in ipairs({ 1, 2, 3, 4 }) do
  local bind = find("<leader>w" .. n)
  check("bind <leader>w" .. n .. " exists with method", bind ~= nil and type(bind.method) == "function")
  if bind then bind.method() end
end

check("adapter received counts 1,2,3,4 in order",
  #captured == 4 and captured[1] == 1 and captured[2] == 2 and captured[3] == 3 and captured[4] == 4)

if failures > 0 then vim.cmd("cq") end
