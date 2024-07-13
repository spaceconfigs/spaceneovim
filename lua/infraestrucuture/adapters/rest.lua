local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	require("infraestrucuture.plugins.rest")
end

M.send = function(opts)
	local message = {
		module = "adapters/request",
		func = "search",
		opts = opts,
	}
	logger_use_manage.debug(message)
	setup()

	vim.cmd("Rest run")
end

return M
