local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").commenter()
end

M.toggle_current_line_visual_mode = function()
	local adapter = M.setup()

	local key = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(key, "nx", false)
	local mode = vim.fn.visualmode()

	adapter.toggle({ mode = mode })
end

M.toggle_current_line = function()
	local adapter = M.setup()

	adapter.toggle()
end

return make_logged("use_cases/commenter", M)
