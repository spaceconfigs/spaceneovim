local M = {}

local logger_use_manage = require("application.use_cases.logger")
local cmp = require("infraestrucuture.plugins.completer")

M.complete = function()
	local message = {
		module = "adapters/completer",
		func = "complete",
	}
	logger_use_manage.debug(message)

	if cmp.visible() then
		cmp.abort()
	end

	cmp.complete()
end

return M
