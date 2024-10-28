local M = {}

local logger_use_case = require("application.use_cases.logger")
local tree_use_case = require("application.use_cases.tree")

M.open = function()
	return function()
		local message = {
			module = "controllers/tree",
			func = "open",
		}
		logger_use_case.debug(message)
		tree_use_case.open()
	end
end

M.close = function()
	return function()
		local message = {
			module = "controllers/tree",
			func = "close",
		}
		logger_use_case.debug(message)
		tree_use_case.close()
	end
end

M.toggle = function(opts)
	return function()
		local message = {
			module = "controllers/tree",
			func = "toggle",
			opts = opts,
		}
		logger_use_case.debug(message)
		tree_use_case.toggle(opts)
	end
end

return M
