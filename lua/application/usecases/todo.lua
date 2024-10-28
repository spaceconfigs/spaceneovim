---@type TodoUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").todo()
	end,

	list = function()
		local adapter = M.setup()

		adapter.list()
	end,
}

return make_logged("usecases/todo", M)
