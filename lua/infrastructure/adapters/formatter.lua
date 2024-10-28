local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.formatter")

M.format = function()
	local message = {
		module = "adapters/formatter",
		func = "format",
	}
	logger_use_case.debug(message)

	plugin.format({
		lsp_fallback = true,
		async = true,
	})
end

return M
