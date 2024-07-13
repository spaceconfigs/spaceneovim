local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")

local require_plugins = function()
	local file = require("infraestrucuture.plugins.file")
	local plugins = require("infraestrucuture.plugins.buffer")

	plugins.file = file
	return plugins
end

M.list = function()
	local message = {
		module = "adapters/buffer",
		func = "list",
	}
	logger_use_manage.debug(message)
	local plugins = require_plugins()
	local file = plugins.file
	local builtin = file.builtin

	builtin.buffers()
end

M.delete = function()
	local message = {
		module = "adapters/buffer",
		func = "delete",
	}
	logger_use_manage.debug(message)
	local plugins = require_plugins()
	local bufdelete = plugins.bufdelete

	bufdelete.bufdelete(0)
end

M.next = function()
	local message = {
		module = "adapters/buffer",
		func = "next",
	}
	logger_use_manage.debug(message)

	vim.cmd("bnext")
end

M.previous = function()
	local message = {
		module = "adapters/buffer",
		func = "previous",
	}
	logger_use_manage.debug(message)

	vim.cmd("bprevious")
end

M.reopen = function()
	local message = {
		module = "adapters/buffer",
		func = "reopen",
	}
	logger_use_manage.debug(message)

	vim.cmd("buffer #")
end

M.messages = function()
	local message = {
		module = "adapters/buffer",
		func = "messages",
	}
	logger_use_manage.debug(message)

	vim.cmd("messages")
end

M.lsp_symbols = function()
	local message = {
		module = "adapters/buffer",
		func = "lsp_symbols",
	}
	logger_use_manage.debug(message)

	local plugins = require_plugins()
	local outline = plugins.outline
	local file = plugins.file
	local builtin = file.builtin

	outline.open({ focus_outline = false })
	builtin.lsp_document_symbols()
end

M.diagnostics = function()
	local message = {
		module = "adapters/buffer",
		func = "diagnostics",
	}
	logger_use_manage.debug(message)

	local plugins = require_plugins()
	local file = plugins.file
	local builtin = file.builtin

	builtin.diagnostics()
end

M.lsp_references = function()
	local message = {
		module = "adapters/buffer",
		func = "lsp_references",
	}
	logger_use_manage.debug(message)

	local plugins = require_plugins()
	local file = plugins.file
	local builtin = file.builtin

	builtin.lsp_references({ show_line = false })
end

M.lsp_definitions = function()
	local message = {
		module = "adapters/buffer",
		func = "lsp_definitions",
	}
	logger_use_manage.debug(message)

	local plugins = require_plugins()
	local file = plugins.file
	local builtin = file.builtin

	builtin.lsp_definitions({ show_line = false })
end

M.lsp_implementations = function()
	local message = {
		module = "adapters/buffer",
		func = "lsp_implementations",
	}
	logger_use_manage.debug(message)

	local plugins = require_plugins()
	local file = plugins.file
	local builtin = file.builtin

	builtin.lsp_implementations({ show_line = false })
end

M.close_others = function()
	local message = {
		module = "adapters/buffer",
		func = "close_others",
	}
	logger_use_manage.debug(message)

	local plugins = require_plugins()
	local bufferline = plugins.bufferline

	bufferline.close_others()
end

return M
