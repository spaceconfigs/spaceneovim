local vim = vim
local M = {}

M.setup = function()
	return require("infrastructure.adapters.window")
end

M.toggle = function()
	local adapter = M.setup()

	adapter.toggle()
end

M.shrink_height = function()
	vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) + 5)
end

M.expand_height = function()
	vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) - 5)
end

M.shrink_width = function()
	vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) + 5)
end

M.expand_width = function()
	vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) - 5)
end

M.balance_area = function()
	vim.cmd("wincmd =")
end

M.move_far_up = function()
	local adapter = M.setup()

	adapter.move_far_up()
end

M.move_far_down = function()
	local adapter = M.setup()

	adapter.move_far_down()
end

M.move_far_left = function()
	local adapter = M.setup()

	adapter.move_far_left()
end

M.move_far_right = function()
	local adapter = M.setup()

	adapter.move_far_right()
end

M.go_left = function()
	local adapter = M.setup()

	adapter.go_left()
end

M.go_right = function()
	local adapter = M.setup()

	adapter.go_right()
end

M.go_up = function()
	local adapter = M.setup()

	adapter.go_up()
end

M.go_down = function()
	local adapter = M.setup()

	adapter.go_down()
end

M.move_left = function()
	local adapter = M.setup()

	adapter.move_left()
end

M.move_right = function()
	local adapter = M.setup()

	adapter.move_right()
end

M.move_up = function()
	local adapter = M.setup()

	adapter.move_up()
end

M.move_down = function()
	local adapter = M.setup()

	adapter.move_down()
end

M.go_to = function(number)
	local adapter = M.setup()

	adapter.go_to(number)
end

M.close = function()
	local adapter = M.setup()

	adapter.close()
end

M.split = function()
	local adapter = M.setup()

	adapter.split()
end

M.vsplit = function()
	local adapter = M.setup()

	adapter.vsplit()
end

M.split_previous = function()
	local adapter = M.setup()

	adapter.split_previous()
end

M.vsplit_previous = function()
	local adapter = M.setup()

	adapter.vsplit_previous()
end

M.dedicate = function()
	local adapter = M.setup()

	adapter.dedicate()
end

return M
