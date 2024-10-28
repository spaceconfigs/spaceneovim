local M = {}

local logger_use_case = require("application.use_cases.logger")

M.number = function()
	local message = {
		module = "adapters/toggler",
		func = "number",
	}
	logger_use_case.debug(message)

	vim.cmd("set number")
end

M.wrap = function()
	local message = {
		module = "adapters/toggler",
		func = "wrap",
	}
	logger_use_case.debug(message)

	vim.cmd("set wrap!")
end

return M
