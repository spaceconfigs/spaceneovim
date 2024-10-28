local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.jumper")
end

M.timer = function(options)
	local message = {
		module = "use_cases/jumper",
		func = "words",
		options = options,
	}
	logger_use_case.debug(message)
	local adapter = M.setup()
	options = options or {}

	adapter.timer(options)
end

M.words = function()
	local message = {
		module = "use_cases/jumper",
		func = "words",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.words()
end

M.lines = function()
	local message = {
		module = "use_cases/jumper",
		func = "lines",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.lines()
end

M.remote = function()
	local message = {
		module = "use_cases/remote",
		func = "lines",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.remote()
end
return M
