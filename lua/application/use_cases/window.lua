local vim = vim
local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.window")

M.toggle = function()
	local message = {
		module = "use_cases/window",
		func = "toggle",
	}
	logger_use_case.debug(message)

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
	adapter.move_far_up()
end

M.move_far_down = function()
	adapter.move_far_down()
end

M.move_far_left = function()
	adapter.move_far_left()
end

M.move_far_right = function()
	adapter.move_far_right()
end
return M
