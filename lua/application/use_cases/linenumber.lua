local M = {}

M.toggle_absolute = function()
	if vim.opt.number:get() then
		vim.opt.number = false
		return
	end

	vim.opt.number = true
end

M.toggle_relative = function()
	if vim.opt.relativenumber:get() then
		vim.opt.relativenumber = false
		return
	end

	vim.opt.relativenumber = true
end

return M
