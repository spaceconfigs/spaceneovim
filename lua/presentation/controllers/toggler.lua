local make_controller_logged = require("application.helpers.make_controller_logged")
local toggler_usecase = require("application.ports.use_case_registry").toggler()

---@type TogglerContract
local M = {
	number = function()
		return function()
			toggler_usecase.number()
		end
	end,

	wrap = function()
		return function()
			toggler_usecase.wrap()
		end
	end,
}

return make_controller_logged("toggler", M)
