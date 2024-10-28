local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugins = require("infraestrucuture.plugins.outline")
local outline = plugins.outline

M.toggle = function()
	local message = {
		module = "adapters/outline",
		func = "toggle",
	}
	logger_use_manage.debug(message)

	outline.toggle({ focus_outline = false })
end

return M
