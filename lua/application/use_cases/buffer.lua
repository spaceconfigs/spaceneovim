local M = {}

local logger_use_case = require("application.use_cases.logger")

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

return M
