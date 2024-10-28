local M = {}

local logger_use_case = require("application.use_cases.logger")
local packager_use_case = require("application.use_cases.packager")

M.install = function()
	return function()
		local message = {
			module = "controllers/packager",
			func = "install",
		}
		logger_use_case.debug(message)
		packager_use_case.install()
	end
end

M.update = function()
	return function()
		local message = {
			module = "controllers/packager",
			func = "update",
		}
		logger_use_case.debug(message)
		packager_use_case.update()
	end
end

return M
