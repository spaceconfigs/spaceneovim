local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.tester")
local neotest = plugin.neotest

M.toggle = function()
	local message = {
		module = "adapters/tester",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	neotest.summary.toggle()
end

M.run = function()
	local message = {
		module = "adapters/tester",
		func = "run",
	}
	logger_use_manage.debug(message)

	neotest.run.run(vim.fn.expand("%"))
end

return M
