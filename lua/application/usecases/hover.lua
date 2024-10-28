---@type HoverUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").hover()
	end,

	toggle = function()
		local adapter = M.setup()

		adapter.toggle()
	end,

	dismiss = function()
		local adapter = M.setup()

		adapter.dismiss()
	end,
}
return make_logged("usecases/hover", M)
