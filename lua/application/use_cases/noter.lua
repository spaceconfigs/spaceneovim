local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.noter")

M.add = function()
	local message = {
		module = "use_cases/noter",
		func = "add",
	}
	logger_use_case.debug(message)
end

M.list = function()
	local message = {
		module = "use_cases/noter",
		func = "list",
	}
	logger_use_case.debug(message)

	adapter.list()
end

M.dismiss = function()
	local message = {
		module = "use_cases/noter",
		func = "dismiss",
	}
	logger_use_case.debug(message)

	adapter.dismiss()
end

M.find = function()
	local message = {
		module = "use_cases/noter",
		func = "find",
	}
	logger_use_case.debug(message)

	adapter.find()
end

M.toggle_checkbox = function()
	local message = {
		module = "use_cases/noter",
		func = "toggle_checkbox",
	}
	logger_use_case.debug(message)

	adapter.checkbox("toggle")
end

M.todo_next_state = function()
	local message = {
		module = "use_cases/noter",
		func = "change_todo_state",
	}
	logger_use_case.debug(message)

	adapter.todo("next_state")
end

M.insert_heading = function()
	local message = {
		module = "use_cases/noter",
		func = "insert_heading",
	}
	logger_use_case.debug(message)

	adapter.insert_heading("same")
end

return M
