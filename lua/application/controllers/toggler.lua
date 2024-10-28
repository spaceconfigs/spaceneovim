local M = {}

local logger_use_case = require("application.use_cases.logger")
local toggler_use_case = require("application.use_cases.toggler")

M.number = function()
	return function()
		local message = {
			module = "controllers/toggler",
			func = "number",
		}
		logger_use_case.debug(message)
		toggler_use_case.number()
	end
end

M.wrap = function()
	return function()
		local message = {
			module = "controllers/toggler",
			func = "wrap",
		}
		logger_use_case.debug(message)
		toggler_use_case.wrap()
	end
end

return M
