---@type DatabaseUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").database()
	end,

	open = function()
		local adapter = M.setup()

		adapter.open()
	end,
}

return make_logged("usecases/database", M)
