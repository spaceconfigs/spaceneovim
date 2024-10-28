local M = {}

local logger_use_case = require("application.use_cases.logger")
local layout_use_case = require("application.use_cases.layout")

M.list = function()
	return function()
		local message = {
			module = "controllers/layout",
			func = "list",
		}
		logger_use_case.debug(message)
		layout_use_case.list()
	end
end

M.reload = function()
	return function()
		local message = {
			module = "controllers/layout",
			func = "reload",
		}
		logger_use_case.debug(message)
		layout_use_case.reload()
	end
end

M.save = function()
	return function()
		local message = {
			module = "controllers/layout",
			func = "save",
		}
		logger_use_case.debug(message)
		layout_use_case.save()
	end
end

M.delete = function()
	return function()
		local message = {
			module = "controllers/layout",
			func = "delete",
		}
		logger_use_case.debug(message)
		layout_use_case.delete()
	end
end

M.rename = function()
	return function()
		local message = {
			module = "controllers/layout",
			func = "rename",
		}
		logger_use_case.debug(message)
		layout_use_case.rename()
	end
end

M.previous = function()
	return function()
		local message = {
			module = "controllers/layout",
			func = "previous",
		}
		logger_use_case.debug(message)
		layout_use_case.previous()
	end
end

return M
