local M = {}

local logger_use_case = require("application.use_cases.logger")
local linenumber_use_case = require("application.use_cases.linenumber")

M.toggle = function(opts)
	return function()
		local message = {
			module = "controllers/linenumber",
			func = "toggle",
			opts = opts,
		}
		logger_use_case.debug(message)
		linenumber_use_case.toggle(opts.type)
	end
end

return M
