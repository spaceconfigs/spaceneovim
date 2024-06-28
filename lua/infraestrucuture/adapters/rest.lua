local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.rest")

M.toggle = function(opts)
	local message = {
		module = "adapters/request",
		func = "search",
		opts = opts,
	}
	logger_use_manage.debug(message)

	plugin.show()
end

return M
