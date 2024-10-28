local make_controller_logged = require("application.helpers.make_controller_logged")
local linenumber_usecase = require("application.ports.use_case_registry").linenumber()

---@type LinenumberContract
local M = {
	toggle = function(opts)
		return function()
			linenumber_usecase.toggle(opts.type)
		end
	end,
}

return make_controller_logged("linenumber", M)
