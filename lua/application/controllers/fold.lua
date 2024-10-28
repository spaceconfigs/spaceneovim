local make_controller_logged = require("application.helpers.make_controller_logged")
local fold_use_case = require("application.ports.use_case_registry").fold()

---@type FoldContract
local M = {
	fold = function(opts)
		return function()
			fold_use_case.fold(opts.action, opts)
		end
	end,
}

return make_controller_logged("fold", M)
