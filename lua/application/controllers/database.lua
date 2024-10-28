local M = {}

local logger_use_case = require("application.use_cases.logger")
local database_use_case = require("application.use_cases.database")

M.open = function()
	return function()
		local message = {
			module = "controllers/database",
			func = "open",
		}
		logger_use_case.debug(message)
		database_use_case.open()
	end
end

return M
