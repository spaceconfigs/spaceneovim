local make_controller_logged = require("application.helpers.make_controller_logged")
local screenshot_usecase = require("application.ports.use_case_registry").screenshot()

---@type ScreenshotContract
local M = {
	capture = function(opts)
		return function()
			screenshot_usecase.capture(opts.action, opts)
		end
	end,
}

return make_controller_logged("screenshot", M)
