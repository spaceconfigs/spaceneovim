local M = {}

local logger_use_case = require("application.use_cases.logger")
local zoom_use_case = require("application.use_cases.zoom")

M.change = function(opts)
	return function()
		local message = {
			module = "controllers/zoom",
			func = "change",
			opts = opts,
		}
		logger_use_case.debug(message)
		zoom_use_case.change(opts)
	end
end

return M
