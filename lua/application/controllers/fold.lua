local M = {}

local logger_use_case = require("application.use_cases.logger")
local fold_use_case = require("application.use_cases.fold")

M.open = function(opts)
	return function()
		local message = {
			module = "controllers/fold",
			func = "open",
			opts = opts,
		}
		logger_use_case.debug(message)
		fold_use_case.open(opts)
	end
end

M.close = function(opts)
	return function()
		local message = {
			module = "controllers/fold",
			func = "close",
			opts = opts,
		}
		logger_use_case.debug(message)
		fold_use_case.close(opts)
	end
end

M.toggle = function(opts)
	return function()
		local message = {
			module = "controllers/fold",
			func = "toggle",
			opts = opts,
		}
		logger_use_case.debug(message)
		fold_use_case.toggle(opts)
	end
end

return M
