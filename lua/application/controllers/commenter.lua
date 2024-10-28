local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local commenter_use_case = require("application.use_cases.commenter")

M.toggle_current_line_visual_mode = function()
	return function()
		commenter_use_case.toggle_current_line_visual_mode()
	end
end

M.toggle_current_line = function()
	return function()
		commenter_use_case.toggle_current_line()
	end
end

return make_controller_logged("commenter", M)
