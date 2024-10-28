local make_controller_logged = require("application.helpers.make_controller_logged")
local fold_usecase = require("application.ports.usecase_registry").fold()

---@type FoldContract
local M = {
	fold = function(opts)
		return function()
			fold_usecase.fold(opts.action, opts)
		end
	end,
}

return make_controller_logged("fold", M)
