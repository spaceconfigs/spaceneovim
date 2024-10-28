---@type ThemeUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").theme()
	end,

	list = function()
		local adapter = M.setup()

		adapter.list()
	end,

	load = function()
		local adapter = M.setup()

		adapter.load()
	end,
}

return make_logged("usecases/theme", M)
