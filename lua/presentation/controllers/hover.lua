local make_controller_logged = require("application.helpers.make_controller_logged")
local hover_usecase = require("application.ports.usecase_registry").hover()

---@type HoverContract
local M = {
	toggle = function()
		return function()
			hover_usecase.toggle()
		end
	end,

	dismiss = function()
		return function()
			hover_usecase.dismiss()
		end
	end,
}

return make_controller_logged("hover", M)
