local M = {}

local logger_use_case = require("application.use_cases.logger")
local commander_use_case = require("application.use_cases.commander")

M.find = function()
	return function()
		local message = {
			module = "controllers/commander",
			func = "find",
		}
		logger_use_case.debug(message)
		commander_use_case.find()
	end
end

return M
