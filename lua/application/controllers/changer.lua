local M = {}

local logger_use_case = require("application.use_cases.logger")
local changer_use_case = require("application.use_cases.changer")

M.list = function()
	return function()
		local message = {
			module = "controllers/changer",
			func = "list",
		}
		logger_use_case.debug(message)
		changer_use_case.list()
	end
end

return M
