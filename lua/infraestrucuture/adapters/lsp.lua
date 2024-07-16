local vim = vim
local M = {}

require("infraestrucuture.plugins.treesitter")
local logger_use_manage = require("application.use_cases.logger")
local lsp = require("infraestrucuture.plugins.lsp")

local mason_lspconfig = lsp.mason_lspconfig
local lspconfig = lsp.lspconfig
local cmp_nvim_lsp = lsp.cmp_nvim_lsp

vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "DiagnosticDefault" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌶", numhl = "DiagnosticDefault" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "DiagnosticDefault" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "DiagnosticDefault" })

local capabilities = cmp_nvim_lsp.default_capabilities()
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

	lspconfig[server].setup(config)
end

M.go_declaration = function()
	local message = {
		module = "adapters/lsp",
		func = "go_declaration",
	}
	logger_use_manage.debug(message)

	vim.lsp.buf.declaration()
end

M.go_definition = function()
	local message = {
		module = "adapters/lsp",
		func = "go_definition",
	}
	logger_use_manage.debug(message)

	vim.lsp.buf.definition()
end

M.go_implementation = function()
	local message = {
		module = "adapters/lsp",
		func = "go_implementation",
	}
	logger_use_manage.debug(message)

	vim.lsp.buf.implementation()
end

M.go_references = function()
	local message = {
		module = "adapters/lsp",
		func = "go_references",
	}
	logger_use_manage.debug(message)

	vim.lsp.buf.references()
end

M.go_typedefinition = function()
	local message = {
		module = "adapters/lsp",
		func = "go_typedefinition",
	}
	logger_use_manage.debug(message)

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

return M
