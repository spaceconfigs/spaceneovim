local M = {}

local logger_use_case = require("application.use_cases.logger")
local noter_use_case = require("application.use_cases.noter")

M.new = function()
	return function()
		local message = {
			module = "controllers/noter",
			func = "new",
		}
		logger_use_case.debug(message)
		noter_use_case.new()
	end
end

M.list = function()
	return function()
		local message = {
			module = "controllers/noter",
			func = "list",
		}
		logger_use_case.debug(message)
		noter_use_case.list()
	end
end

M.dismiss = function()
	return function()
		local message = {
			module = "controllers/noter",
			func = "dismiss",
		}
		logger_use_case.debug(message)
		noter_use_case.dismiss()
	end
end

M.find = function()
	return function()
		local message = {
			module = "controllers/noter",
			func = "find",
		}
		logger_use_case.debug(message)
		noter_use_case.find()
	end
end

M.toggle_checkbox = function()
	return function()
		local message = {
			module = "controllers/noter",
			func = "toggle_checkbox",
		}
		logger_use_case.debug(message)
		noter_use_case.toggle_checkbox()
	end
end

M.todo_next_state = function()
	return function()
		local message = {
			module = "controllers/noter",
			func = "todo_next_state",
		}
		logger_use_case.debug(message)
		noter_use_case.todo_next_state()
	end
end

M.insert_heading = function()
	return function()
		local message = {
			module = "controllers/noter",
			func = "insert_heading",
		}
		logger_use_case.debug(message)
		noter_use_case.insert_heading()
	end
end

return M
