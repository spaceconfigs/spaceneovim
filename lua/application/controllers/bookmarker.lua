local M = {}

local logger_use_case = require("application.use_cases.logger")
local bookmarker_use_case = require("application.use_cases.bookmarker")

M.add = function()
	return function()
		local message = {
			module = "controllers/bookmarker",
			func = "add",
		}
		logger_use_case.debug(message)
		bookmarker_use_case.add()
	end
end

M.remove = function()
	return function()
		local message = {
			module = "controllers/bookmarker",
			func = "remove",
		}
		logger_use_case.debug(message)
		bookmarker_use_case.remove()
	end
end

M.remove_all = function()
	return function()
		local message = {
			module = "controllers/bookmarker",
			func = "remove_all",
		}
		logger_use_case.debug(message)
		bookmarker_use_case.remove_all()
	end
end

M.list = function()
	return function()
		local message = {
			module = "controllers/bookmarker",
			func = "list",
		}
		logger_use_case.debug(message)
		bookmarker_use_case.list()
	end
end

return M
