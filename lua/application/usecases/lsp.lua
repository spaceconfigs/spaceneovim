---@type LspUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").lsp()
	end,

	navigate = function(type, options)
		local adapter = M.setup()

		options = options or {}
		options.type = options.type or "local"

		adapter.navigate(type, options)
	end,

	show_signature = function()
		local adapter = M.setup()

		adapter.show_signature()
	end,

	show_documentation = function()
		local adapter = M.setup()

		adapter.show_documentation()
	end,

	show_code_action = function()
		local adapter = M.setup()

		adapter.show_code_action()
	end,

	format = function()
		local adapter = M.setup()

		adapter.format()
	end,

	diagnostics = function()
		local adapter = M.setup()

		adapter.diagnostics()
	end,

	info = function()
		local adapter = M.setup()

		adapter.info()
	end,

	restart = function()
		local adapter = M.setup()

		adapter.restart()
	end,

	rename = function()
		local adapter = M.setup()

		adapter.rename()
	end,

	get_symbol = function()
		local adapter = M.setup()

		adapter.get_symbol()
	end,
}

return make_logged("usecases/lsp", M)
