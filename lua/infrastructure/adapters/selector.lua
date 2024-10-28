local M = {}

local logger_use_case = require("application.use_cases.logger")
require("infrastructure.plugins.selector")

M.all_selected = function()
	local message = {
		module = "adapters/selector",
		func = "all_selected",
	}
	logger_use_case.debug(message)

	vim.cmd("MCstart")
end

M.quit = function()
	local message = {
		module = "adapters/selector",
		func = "quit",
	}
	logger_use_case.debug(message)

	vim.cmd("MCclear")
end

return M
