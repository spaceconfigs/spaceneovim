local M = {}

local logger_use_case = require("application.use_cases.logger")
local todo_use_case = require("application.use_cases.todo")

M.list = function()
	return function()
		local message = {
			module = "controllers/todo",
			func = "list",
		}
		logger_use_case.debug(message)
		todo_use_case.list()
	end
end

return M
