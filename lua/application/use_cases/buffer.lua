local M = {}

local logger_use_case = require("application.use_cases.logger")
local tree_adapter = require("infraestrucuture.adapters.tree")

M.setup = function()
	return require("infraestrucuture.adapters.buffer")
end

M.add = function()
	local message = {
		module = "use_cases/buffer",
		func = "add",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.add()
end

M.delete = function()
	local message = {
		module = "use_cases/buffer",
		func = "delete",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()
	tree_adapter.close()
	adapter.delete()
end

M.close_others = function()
	local message = {
		module = "use_cases/buffer",
		func = "remove_all",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.close_others()
end

M.list = function()
	local message = {
		module = "use_cases/buffer",
		func = "list",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.list()
end

M.next = function()
	local message = {
		module = "use_cases/buffer",
		func = "next",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.next()
end

M.previous = function()
	local message = {
		module = "use_cases/buffer",
		func = "previous",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.previous()
end

M.reopen = function()
	local message = {
		module = "use_cases/buffer",
		func = "reopen",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.reopen()
end

M.messages = function()
	local message = {
		module = "use_cases/buffer",
		func = "messages",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.messages()
end

M.list_persp = function()
	local message = {
		module = "use_cases/buffer",
		func = "list_persp",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.list_persp()
end

M.lsp_symbols = function()
	local message = {
		module = "use_cases/buffer",
		func = "lsp_symbols",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.lsp_symbols()
end

M.lsp_references = function()
	local message = {
		module = "use_cases/buffer",
		func = "lsp_references",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.diagnostics()
end

M.lsp_definitions = function()
	local message = {
		module = "use_cases/buffer",
		func = "lsp_definitions",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.diagnostics()
end

M.lsp_implementations = function()
	local message = {
		module = "use_cases/buffer",
		func = "lsp_implementations",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.diagnostics()
end

M.diagnostics = function()
	local message = {
		module = "use_cases/buffer",
		func = "diagnostics",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.diagnostics()
end

return M
