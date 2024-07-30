local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.hover")

M.toggle = function()
	local message = {
		module = "adapters/hover",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	plugin.hover()
end

return M
