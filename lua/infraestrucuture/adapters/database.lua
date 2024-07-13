local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")

local require_plugin = function()
	return require("infraestrucuture.plugins.database")
end

M.open = function()
	local message = {
		module = "adapters/database",
		func = "open",
	}
	logger_use_manage.debug(message)
	require_plugin()

	vim.cmd("DBUI")
end

return M
