local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")
local file = require("infraestrucuture.plugins.file")
local plugins = require("infraestrucuture.plugins.buffer")

local outline = plugins.outline
local bufferline = plugins.bufferline
local bufdelete = plugins.bufdelete
local builtin = file.builtin

M.list = function()
	local message = {
		module = "adapters/buffer",
		func = "list",
	}
	logger_use_manage.debug(message)

	builtin.buffers()
end

M.delete = function()
	local message = {
		module = "adapters/buffer",
		func = "delete",
	}
	logger_use_manage.debug(message)

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

	outline.open({ focus_outline = false })
	builtin.lsp_document_symbols()
end

M.diagnostics = function()
	local message = {
		module = "adapters/buffer",
		func = "diagnostics",
	}
	logger_use_manage.debug(message)

	builtin.diagnostics()
end

M.lsp_references = function()
	local message = {
		module = "adapters/buffer",
		func = "lsp_references",
	}
	logger_use_manage.debug(message)

	builtin.lsp_references({ show_line = false })
end

M.lsp_definitions = function()
	local message = {
		module = "adapters/buffer",
		func = "lsp_definitions",
	}
	logger_use_manage.debug(message)

	builtin.lsp_definitions({ show_line = false })
end

M.lsp_implementations = function()
	local message = {
		module = "adapters/buffer",
		func = "lsp_implementations",
	}
	logger_use_manage.debug(message)

	builtin.lsp_implementations({ show_line = false })
end

M.close_others = function()
	bufferline.close_others()
end

return M
