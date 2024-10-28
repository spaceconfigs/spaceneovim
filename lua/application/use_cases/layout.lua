local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.layout")
end

M.list = function()
	local message = {
		module = "use_cases/layout",
		func = "list",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.list()
end

M.reload = function()
	local message = {
		module = "use_cases/layout",
		func = "reload",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.reload()
end

M.save = function()
	local message = {
		module = "use_cases/layout",
		func = "save",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.save()
end

M.delete = function()
	local message = {
		module = "use_cases/layout",
		func = "delete",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.delete()
end

M.rename = function()
	local message = {
		module = "use_cases/layout",
		func = "rename",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.rename()
end

M.previous = function()
	local message = {
		module = "use_cases/layout",
		func = "previous",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.previous()
end
return M
