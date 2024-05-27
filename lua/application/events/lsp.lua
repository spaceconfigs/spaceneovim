local M = {}

local logger_use_case = require("application.use_cases.logger")
local keymapper_use_case = require("application.use_cases.keymapper")
local lsp_use_case = require("application.use_cases.lsp")

local attach_lsp_binds = function(opts)
	local message = {
		module = "events/lsp",
		func = "attach_lsp_binds",
		opts = opts,
	}
	logger_use_case.debug(message)

	local common_config = {
		mode = "n",
		buffer = opts.buffer,
		silent = true,
		noremap = true,
		nowait = false,
	}

	local config = vim.deepcopy(common_config)
	config.key = opts.key
	config.method = opts.method
	config.description = opts.description
	-- local map = keymapper_use_case.format(config)
	-- keymapper_use_case.register(map)
	keymapper_use_case.register(config)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		attach_lsp_binds({
			key = "gd",
			method = lsp_use_case.go_definition,
			description = "Goto definition",
			buffer = ev.buf,
		})

		attach_lsp_binds({
			key = "gi",
			method = lsp_use_case.go_implementation,
			description = "Goto implementation",
			buffer = ev.buf,
		})

		attach_lsp_binds({
			key = "gr",
			method = lsp_use_case.go_references,
			description = "Goto references",
			buffer = ev.buf,
		})

		attach_lsp_binds({
			key = "gD",
			method = lsp_use_case.go_declaretion,
			description = "Goto declaration",
			buffer = ev.buf,
		})

		attach_lsp_binds({
			key = "K",
			description = "Hover",
			method = vim.lsp.buf.hover,
			buffer = ev.buf,
		})
	end,
})

return M
