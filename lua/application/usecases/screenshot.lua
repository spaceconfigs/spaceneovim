---@type ScreenshotUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").screenshot()
	end,

	capture = function(action, options)
		local adapter = M.setup()

		options = options or {}
		options.type = options.type or ""

		adapter.capture(action, options)
	end,
}

return make_logged("usecases/screenshot", M)
