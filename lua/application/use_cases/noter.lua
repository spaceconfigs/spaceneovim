local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.noter")
end

M.add = function()
	local message = {
		module = "use_cases/noter",
		func = "add",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()
end

M.list = function()
	local message = {
		module = "use_cases/noter",
		func = "list",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.list()
end

M.dismiss = function()
	local message = {
		module = "use_cases/noter",
		func = "dismiss",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.dismiss()
end

M.find = function()
	local message = {
		module = "use_cases/noter",
		func = "find",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.find()
end

M.toggle_checkbox = function()
	local message = {
		module = "use_cases/noter",
		func = "toggle_checkbox",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.checkbox("toggle")
end

M.todo_next_state = function()
	local message = {
		module = "use_cases/noter",
		func = "change_todo_state",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.todo("next_state")
end

M.insert_heading = function()
	local message = {
		module = "use_cases/noter",
		func = "insert_heading",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.insert_heading("same")
end

return M
