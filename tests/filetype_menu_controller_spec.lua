-- Headless spec: keymapper controller `open` delegates a one-shot popup to the usecase.
--   nvim --headless -u NONE -c "luafile tests/filetype_menu_controller_spec.lua" -c "qa!"
package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path

package.loaded["application.usecases.logger"] =
  { debug = function() end, info = function() end, warn = function() end, error = function() end, log = function() end }

local captured = {}
package.loaded["application.usecases.keymapper"] = {
  show = function(opts)
    captured[#captured + 1] = opts
  end,
}

local controller = require("presentation.controllers.keymapper")

local failures = 0
local function check(label, cond)
  print((cond and "ok   - " or "FAIL - ") .. label)
  if not cond then
    failures = failures + 1
  end
end

check("open exists", type(controller.open) == "function")

local action = controller.open({ keys = "<F13>" })
check("open returns a closure", type(action) == "function")
check("open does not fire at definition time", #captured == 0)

action()
check("invoking the closure calls the usecase once", #captured == 1)
check("keys are forwarded", captured[1] and captured[1].keys == "<F13>")
check("open is one-shot, not a transient loop", captured[1] and not captured[1].loop)

-- activate_transient must keep its existing looping behaviour.
controller.activate_transient({ keys = "<F13>" })()
check("activate_transient still loops", captured[2] and captured[2].loop == true)

if failures > 0 then
  vim.cmd("cq")
end
