local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infrastructure.adapters.jumper")
end

M.timer = function(options)
	return function()
		local message = {
			module = "use_cases/jumper",
			func = "timer",
			options = options,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()
		options = options or {}

		adapter.timer(options)
	end
end

M.words = function()
	return function()
		local message = {
			module = "use_cases/jumper",
			func = "words",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.words()
	end
end

M.lines = function()
	return function()
		local message = {
			module = "use_cases/jumper",
			func = "lines",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.lines()
	end
end

M.remote = function()
	return function()
		local message = {
			module = "use_cases/jumper",
			func = "remote",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.remote()
	end
end
return M
