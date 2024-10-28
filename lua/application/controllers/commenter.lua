local M = {}

local logger_use_case = require("application.use_cases.logger")
local commenter_use_case = require("application.use_cases.commenter")

M.toggle_current_line_visual_mode = function()
	return function()
		local message = {
			module = "controllers/commenter",
			func = "toggle_current_line_visual_mode",
		}
		logger_use_case.debug(message)
		commenter_use_case.toggle_current_line_visual_mode()
	end
end

M.toggle_current_line = function()
	return function()
		local message = {
			module = "controllers/commenter",
			func = "toggle_current_line",
		}
		logger_use_case.debug(message)
		commenter_use_case.toggle_current_line()
	end
end

return M
