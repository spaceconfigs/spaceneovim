---@type DocumentationUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").documentation()
	end,

	open = function()
		local adapter = M.setup()

		adapter.open()
	end,

	install = function()
		local adapter = M.setup()

		adapter.install()
	end,

	remove = function()
		local adapter = M.setup()

		adapter.remove()
	end,
}

return make_logged("usecases/documentation", M)
