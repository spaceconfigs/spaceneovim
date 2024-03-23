local M = {}

local logger_use_case = require("application.use_cases.logger")
local tree_adapter = require("infraestrucuture.adapters.tree")
local adapter = require("infraestrucuture.adapters.buffer")

M.add = function()
	local message = {
		module = "use_cases/buffer",
		func = "add",
	}
	logger_use_case.debug(message)

	adapter.add()
end

M.delete = function()
	local message = {
		module = "use_cases/buffer",
		func = "delete",
	}
	logger_use_case.debug(message)
	tree_adapter.close()
	adapter.delete()
end

M.close_others = function()
	local message = {
		module = "use_cases/buffer",
		func = "remove_all",
	}
	logger_use_case.debug(message)

	adapter.close_others()
end

M.list = function()
	local message = {
		module = "use_cases/buffer",
		func = "list",
	}
	logger_use_case.debug(message)

	adapter.list()
end

M.next = function()
	local message = {
		module = "use_cases/buffer",
		func = "next",
	}
	logger_use_case.debug(message)

	adapter.next()
end

M.previous = function()
	local message = {
		module = "use_cases/buffer",
		func = "previous",
	}
	logger_use_case.debug(message)

	adapter.previous()
end

M.reopen = function()
	local message = {
		module = "use_cases/buffer",
		func = "reopen",
	}
	logger_use_case.debug(message)

	adapter.reopen()
end

M.messages = function()
	local message = {
		module = "use_cases/buffer",
		func = "messages",
	}
	logger_use_case.debug(message)

	adapter.messages()
end

M.list_persp = function()
	local message = {
		module = "use_cases/buffer",
		func = "list_persp",
	}
	logger_use_case.debug(message)

	adapter.list_persp()
end

M.lsp_symbols = function()
	local message = {
		module = "use_cases/buffer",
		func = "lsp_symbols",
	}
	logger_use_case.debug(message)

	adapter.lsp_symbols()
end

M.lsp_references = function()
	local message = {
		module = "use_cases/buffer",
		func = "lsp_references",
	}
	logger_use_case.debug(message)

	adapter.diagnostics()
end

M.lsp_definitions = function()
	local message = {
		module = "use_cases/buffer",
		func = "lsp_definitions",
	}
	logger_use_case.debug(message)

	adapter.diagnostics()
end

M.lsp_implementations = function()
	local message = {
		module = "use_cases/buffer",
		func = "lsp_implementations",
	}
	logger_use_case.debug(message)

	adapter.diagnostics()
end

M.diagnostics = function()
	local message = {
		module = "use_cases/buffer",
		func = "diagnostics",
	}
	logger_use_case.debug(message)

	adapter.diagnostics()
end

return M
