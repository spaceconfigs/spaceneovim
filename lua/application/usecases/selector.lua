---@type SelectorUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").selector()
	end,

	quit = function()
		local adapter = M.setup()

		adapter.quit()
	end,

	all_selected = function()
		local adapter = M.setup()

		adapter.all_selected()
	end,
}

return make_logged("usecases/selector", M)
