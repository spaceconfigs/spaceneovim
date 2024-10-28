local make_controller_logged = require("application.helpers.make_controller_logged")
local diagnostic_usecase = require("application.ports.use_case_registry").diagnostic()

---@type DiagnosticContract
local M = {
	toggle = function()
		return function()
			diagnostic_usecase.toggle()
		end
	end,

	show = function(direction)
		return function()
			diagnostic_usecase.show(direction)
		end
	end,

	loclist = function()
		return function()
			diagnostic_usecase.loclist()
		end
	end,
}

return make_controller_logged("diagnostic", M)
