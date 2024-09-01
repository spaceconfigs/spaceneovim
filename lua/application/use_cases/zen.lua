local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.zen")
end

M.toggle = function()
	local message = {
		module = "use_cases/zen",
		func = "toggle",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.toggle()
end

M.center = function()
	local message = {
		module = "use_cases/zen",
		func = "center",
	}

	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.center()
end

M.area = function()
	local message = {
		module = "use_cases/zen",
		func = "area",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.area()
end

return M
