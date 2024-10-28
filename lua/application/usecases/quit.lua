---@type QuitUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").quit()
	end,

	quit = function(opts)
		local adapter = M.setup()

		adapter.quit(opts)
	end,

	restart = function()
		local adapter = M.setup()

		adapter.restart()
	end,
}

return make_logged("usecases/quit", M)
