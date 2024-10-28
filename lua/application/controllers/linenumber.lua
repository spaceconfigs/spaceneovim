local make_controller_logged = require("application.helpers.make_controller_logged")
local linenumber_use_case = require("application.use_cases.linenumber")

---@type LinenumberContract
local M = {
	toggle = function(opts)
		return function()
			linenumber_use_case.toggle(opts.type)
		end
	end,
}

return make_controller_logged("linenumber", M)
