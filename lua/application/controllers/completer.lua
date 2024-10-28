local M = {}

local logger_use_case = require("application.use_cases.logger")
local completer_use_case = require("application.use_cases.completer")

M.complete = function()
	return function()
		local message = {
			module = "controllers/completer",
			func = "complete",
		}
		logger_use_case.debug(message)
		completer_use_case.complete()
	end
end

return M
