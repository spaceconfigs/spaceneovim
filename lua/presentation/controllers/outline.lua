local make_controller_logged = require("application.helpers.make_controller_logged")
local outline_usecase = require("application.ports.usecase_registry").outline()

---@type OutlineContract
local M = {
	toggle = function()
		return function()
			outline_usecase.toggle()
		end
	end,
}

return make_controller_logged("outline", M)
