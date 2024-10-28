local M = {}

local logger_use_case = require("application.use_cases.logger")
local selector_use_case = require("application.use_cases.selector")

M.quit = function()
	return function()
		local message = {
			module = "controllers/selector",
			func = "quit",
		}
		logger_use_case.debug(message)
		selector_use_case.quit()
	end
end

M.all_selected = function()
	return function()
		local message = {
			module = "controllers/selector",
			func = "all_selected",
		}
		logger_use_case.debug(message)
		selector_use_case.all_selected()
	end
end

return M
