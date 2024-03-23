local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.database")

M.open = function()
	local message = {
		module = "adapters/database",
		func = "open",
	}
	logger_use_manage.debug(message)

	vim.cmd("DBUI")
end

return M
