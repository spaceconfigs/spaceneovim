local M = {}

local logger_use_case = require("application.use_cases.logger")
local lsp_use_case = require("application.use_cases.lsp")
-- local fold_use_case = require("application.use_cases.fold")

M.onInit = function()
	local message = {
		module = "events/buffer",
		func = "onInit",
	}
	logger_use_case.debug(message)

	lsp_use_case.setup()
	-- fold_use_case.setup()
end

return M
