local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.tester")
local neotest = plugin.neotest

M.toggle = function()
	local message = {
		module = "adapters/tester",
		func = "toggle",
	}
	logger_use_case.debug(message)

	neotest.summary.toggle()
end

M.run = function()
	local message = {
		module = "adapters/tester",
		func = "run",
	}
	logger_use_case.debug(message)

	neotest.run.run(vim.fn.expand("%"))
end

return M
