---@type OutlineUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").outline()
	end,

	toggle = function()
		local adapter = M.setup()

		adapter.toggle()
	end,
}

return make_logged("usecases/outline", M)
