local M = {}

M.setup = function()
	return require("infrastructure.adapters.commenter")
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

return M
