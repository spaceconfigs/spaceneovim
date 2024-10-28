local make_controller_logged = require("application.helpers.make_controller_logged")
local statusline_usecase = require("application.ports.use_case_registry").statusline()

---@type StatuslineContract
local M = {
	toggle = function()
		return function()
			statusline_usecase.toggle()
		end
	end,
}

return make_controller_logged("statusline", M)
