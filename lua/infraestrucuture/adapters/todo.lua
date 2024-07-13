local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	return require("infraestrucuture.plugins.todo-comments")
end

M.list = function()
	local message = {
		module = "adapters/todo",
		func = "list",
	}
	logger_use_manage.debug(message)
	setup()

	vim.api.nvim_command("TodoTelescope")
end

return M
