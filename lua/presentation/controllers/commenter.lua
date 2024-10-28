local make_controller_logged = require("application.helpers.make_controller_logged")
local commenter_usecase = require("application.ports.usecase_registry").commenter()

---@type CommenterContract
local M = {
	toggle_current_line_visual_mode = function()
		return function()
			commenter_usecase.toggle_current_line_visual_mode()
		end
	end,

	toggle_current_line = function()
		return function()
			commenter_usecase.toggle_current_line()
		end
	end,
}

return make_controller_logged("commenter", M)
