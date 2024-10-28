local make_controller_logged = require("application.helpers.make_controller_logged")
local screenshot_use_case = require("application.use_cases.screenshot")

---@type ScreenshotContract
local M = {
	capture = function(opts)
		return function()
			screenshot_use_case.capture(opts.action, opts)
		end
	end,
}

return make_controller_logged("screenshot", M)
