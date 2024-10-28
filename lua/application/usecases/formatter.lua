---@type FormatterUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").formatter()
	end,

	format = function()
		local adapter = M.setup()

		adapter.format()
	end,
}

return make_logged("usecases/formatter", M)
