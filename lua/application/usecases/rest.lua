---@type RestUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").rest()
	end,

	open = function()
		local adapter = M.setup()

		adapter.open()
	end,

	send = function()
		local adapter = M.setup()

		adapter.send()
	end,

	replay = function()
		local adapter = M.setup()

		adapter.replay()
	end,
}

return make_logged("usecases/rest", M)
