---@type ZenUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").zen()
	end,

	toggle = function()
		local adapter = M.setup()

		adapter.toggle()
	end,

	center = function()
		local adapter = M.setup()

		adapter.center()
	end,

	area = function()
		local adapter = M.setup()

		adapter.area()
	end,
}

return make_logged("usecases/zen", M)
