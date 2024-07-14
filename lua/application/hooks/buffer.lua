local M = {}

local logger_use_case = require("application.use_cases.logger")
local use_case = require("application.use_cases.lsp")

M.onInit = function()
	local message = {
		module = "events/buffer",
		func = "onInit",
	}
	logger_use_case.debug(message)

	use_case.setup()
end

return M
