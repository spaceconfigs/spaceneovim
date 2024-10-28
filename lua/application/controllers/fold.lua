local M = {}

local logger_use_case = require("application.use_cases.logger")
local fold_use_case = require("application.use_cases.fold")

M.fold = function(opts)
	return function()
		local message = {
			module = "controllers/fold",
			func = "fold",
			opts = opts,
		}
		logger_use_case.debug(message)
		fold_use_case.fold(opts.action, opts)
	end
end

return M
