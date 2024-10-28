local vim = vim
local M = {}

local logger_use_case = require("application.use_cases.logger")
require("infrastructure.plugins.database")

M.open = function()
	local message = {
		module = "adapters/database",
		func = "open",
	}
	logger_use_case.debug(message)

	vim.cmd("DBUI")
end

return M
