local M = {}

local logger_use_manage = require("application.use_cases.logger")
require("infraestrucuture.plugins.rest")

M.send = function(opts)
	local message = {
		module = "adapters/request",
		func = "search",
		opts = opts,
	}
	logger_use_manage.debug(message)

	vim.cmd("Rest run")
end

return M
