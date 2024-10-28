local make_controller_logged = require("application.helpers.make_controller_logged")
local outline_use_case = require("application.ports.use_case_registry").outline()

---@type OutlineContract
local M = {
	toggle = function()
		return function()
			outline_use_case.toggle()
		end
	end,
}

return make_controller_logged("outline", M)
