local M = {}

local logger_use_case = require("application.use_cases.logger")

M.all = function()
	local message = {
		module = "adapters/quit",
		func = "all",
	}
	logger_use_case.debug(message)

	vim.cmd("confirm qall")
end

M.save_all = function()
	local message = {
		module = "adapters/quit",
		func = "save_all",
	}
	logger_use_case.debug(message)

	vim.cmd("wqall")
end

return M
