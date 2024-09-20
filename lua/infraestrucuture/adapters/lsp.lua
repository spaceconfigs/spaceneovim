local vim = vim
local M = {}

require("infraestrucuture.plugins.treesitter")
local logger_use_manage = require("application.use_cases.logger")
local jumper_use_manage = require("application.use_cases.jumper")
local plugin = require("infraestrucuture.plugins.lsp")

local mason_lspconfig = plugin.mason_lspconfig
local lspconfig = plugin.lspconfig
local cmp_nvim_lsp = plugin.cmp_nvim_lsp

vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "DiagnosticDefault" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌶", numhl = "DiagnosticDefault" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "DiagnosticDefault" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "DiagnosticDefault" })

local cmp_capabilities = cmp_nvim_lsp.default_capabilities()

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local capabilities = vim.tbl_deep_extend("force", cmp_capabilities, lsp_capabilities)

local language_servers = mason_lspconfig.get_installed_servers()
for _, server in pairs(language_servers) do
	local message = {
		module = "adapters/lsp",
		func = "setup",
		server = server,
	}
	logger_use_manage.debug(message)

	local config = { capabilities = capabilities }

	if server == "jdtls" then
		local lombok = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
		config.cmd = { "jdtls", "--jvm-arg=-javaagent:" .. lombok }
	end

	if server == "tsserver" then
		server = "ts_ls"
	end

	lspconfig[server].setup(config)
end

M.declaration = function(options)
	local message = {
		module = "adapters/lsp",
		func = "declaration",
		options = options,
	}
	logger_use_manage.debug(message)

	if options.type == "remote" then
		return jumper_use_manage.timer({
			action = function(match)
				vim.api.nvim_win_call(match.win, function()
					vim.api.nvim_win_set_cursor(match.win, match.pos)
					vim.lsp.buf.declaration()
				end)
			end,
		})
	end

	vim.lsp.buf.declaration()
end

M.definition = function(options)
	local message = {
		module = "adapters/lsp",
		func = "definition",
		options = options,
	}
	logger_use_manage.debug(message)

	if options.type == "remote" then
		return jumper_use_manage.timer({
			action = function(match)
				vim.api.nvim_win_call(match.win, function()
					vim.api.nvim_win_set_cursor(match.win, match.pos)
					vim.lsp.buf.definition()
				end)
			end,
		})
	end

	vim.lsp.buf.definition()
end

M.implementation = function(options)
	local message = {
		module = "adapters/lsp",
		func = "implementation",
		options = options,
	}
	logger_use_manage.debug(message)

	if options.type == "remote" then
		return jumper_use_manage.timer({
			action = function(match)
				vim.api.nvim_win_call(match.win, function()
					vim.api.nvim_win_set_cursor(match.win, match.pos)
					vim.lsp.buf.implementation()
				end)
			end,
		})
	end

	vim.lsp.buf.implementation()
end

M.references = function(options)
	local message = {
		module = "adapters/lsp",
		func = "references",
		options = options,
	}
	logger_use_manage.debug(message)

	if options.type == "remote" then
		return jumper_use_manage.timer({
			action = function(match)
				vim.api.nvim_win_call(match.win, function()
					vim.api.nvim_win_set_cursor(match.win, match.pos)
					vim.lsp.buf.references()
				end)
			end,
		})
	end

	vim.lsp.buf.references()
end

M.typedefinition = function(options)
	local message = {
		module = "adapters/lsp",
		func = "typedefinition",
	}
	logger_use_manage.debug(message)

	if options.type == "remote" then
		return jumper_use_manage.timer({
			action = function(match)
				vim.api.nvim_win_call(match.win, function()
					vim.api.nvim_win_set_cursor(match.win, match.pos)
					vim.lsp.buf.type_definition()
				end)
			end,
		})
	end

	vim.lsp.buf.type_definition()
end

M.show_signature = function()
	local message = {
		module = "adapters/lsp",
		func = "show_signature",
	}
	logger_use_manage.debug(message)

	vim.lsp.buf.signature_help()
end

M.show_documentation = function()
	local message = {
		module = "adapters/lsp",
		func = "show_documentation",
	}
	logger_use_manage.debug(message)

	vim.lsp.buf.hover()
end

M.type_definition = function()
	local message = {
		module = "adapters/lsp",
		func = "type_definition",
	}
	logger_use_manage.debug(message)

	vim.lsp.buf.type_definition()
end

M.show_code_action = function()
	local message = {
		module = "adapters/lsp",
		func = "show_code_action",
	}
	logger_use_manage.debug(message)

	vim.lsp.buf.code_action()
end

M.show_references = function()
	local message = {
		module = "adapters/lsp",
		func = "show_references",
	}
	logger_use_manage.debug(message)

	vim.lsp.buf.references()
end

M.format = function()
	local message = {
		module = "adapters/lsp",
		func = "format",
	}
	logger_use_manage.debug(message)

	vim.lsp.buf.format({ async = true })
end

M.diagnostics = function()
	local message = {
		module = "adapters/lsp",
		func = "diagnostics",
	}
	logger_use_manage.debug(message)

	vim.lsp.diagnostic()
end

M.info = function()
	local message = {
		module = "adapters/lsp",
		func = "info",
	}
	logger_use_manage.debug(message)

	vim.cmd("LspInfo")
end

return M
