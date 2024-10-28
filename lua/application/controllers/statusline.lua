local make_controller_logged = require("application.helpers.make_controller_logged")
local statusline_use_case = require("application.use_cases.statusline")

---@type StatuslineContract
local M = {
	toggle = function()
		return function()
			statusline_use_case.toggle()
		end
	end,
}

return make_controller_logged("statusline", M)
