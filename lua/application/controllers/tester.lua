local M = {}

local logger_use_case = require("application.use_cases.logger")
local tester_use_case = require("application.use_cases.tester")

M.toggle = function(opts)
	return function()
		local message = {
			module = "controllers/tester",
			func = "toggle",
			opts = opts,
		}
		logger_use_case.debug(message)
		tester_use_case.toggle(opts)
	end
end

M.run = function(opts)
	return function()
		local message = {
			module = "controllers/tester",
			func = "run",
			opts = opts,
		}
		logger_use_case.debug(message)
		tester_use_case.run(opts)
	end
end

return M
