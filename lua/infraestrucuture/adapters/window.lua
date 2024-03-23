local M = {}

local logger_use_manage = require("application.use_cases.logger")
local maximize = require("infraestrucuture.plugins.maximize")

M.toggle = function()
	local message = {
		module = "adapters/window",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	maximize.toggle()
end

return M
