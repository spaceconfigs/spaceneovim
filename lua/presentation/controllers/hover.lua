local make_controller_logged = require("application.helpers.make_controller_logged")
local hover_use_case = require("application.ports.use_case_registry").hover()

---@type HoverContract
local M = {
	toggle = function()
		return function()
			hover_use_case.toggle()
		end
	end,

	dismiss = function()
		return function()
			hover_use_case.dismiss()
		end
	end,
}

return make_controller_logged("hover", M)
