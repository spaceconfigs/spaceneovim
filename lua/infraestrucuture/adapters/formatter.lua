local M = {}

local logger_use_manage = require("application.use_cases.logger")
local conform = require("infraestrucuture.plugins.conform")

M.format = function()
	local message = {
		module = "adapters/formatter",
		func = "format",
	}
	logger_use_manage.debug(message)

	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end

return M
