local M = {}

local logger_use_case = require("application.use_cases.logger")
local screenshot_use_case = require("application.use_cases.screenshot")

M.capture = function(opts)
	return function()
		local message = {
			module = "controllers/screenshot",
			func = "capture",
			opts = opts,
		}
		logger_use_case.debug(message)
		screenshot_use_case.capture(opts.action, opts)
	end
end

return M
