local M = {}

local logger_use_case = require("application.use_cases.logger")
local quit_use_case = require("application.use_cases.quit")

M.quit = function(opts)
	return function()
		local message = {
			module = "controllers/quit",
			func = "quit",
			opts = opts,
		}
		logger_use_case.debug(message)
		quit_use_case.quit(opts)
	end
end

return M
