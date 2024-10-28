local make_controller_logged = require("application.helpers.make_controller_logged")
local toggler_use_case = require("application.use_cases.toggler")

---@type TogglerContract
local M = {
	number = function()
		return function()
			toggler_use_case.number()
		end
	end,

	wrap = function()
		return function()
			toggler_use_case.wrap()
		end
	end,
}

return make_controller_logged("toggler", M)
