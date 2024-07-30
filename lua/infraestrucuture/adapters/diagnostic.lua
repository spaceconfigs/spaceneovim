local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.diagnostic")

M.toggle = function()
	local message = {
		module = "adapters/diagnostic",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	plugin.try_lint()
end

return M
