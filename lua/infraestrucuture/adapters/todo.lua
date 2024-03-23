local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")
local todo_comments = require("infraestrucuture.plugins.todo-comments")

M.list = function()
	local message = {
		module = "adapters/todo",
		func = "list",
	}
	logger_use_manage.debug(message)

	vim.api.nvim_command("TodoTelescope")
end

return M
