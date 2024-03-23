local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.commenter")

M.toggle_current_line_visual_mode = function()
	local message = {
		module = "use_cases/commenter",
		func = "toggle_current_line_visual_mode",
	}
	logger_use_case.debug(message)

	local key = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(key, "nx", false)
	local mode = vim.fn.visualmode()

	adapter.toggle({ mode = mode })
end

M.toggle_current_line = function()
	local message = {
		module = "use_cases/commenter",
		func = "toggle_current_line",
	}
	logger_use_case.debug(message)

	adapter.toggle()
end

return M
