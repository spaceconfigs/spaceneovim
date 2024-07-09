local winshift_ok, winshift = pcall(require, "winshift")
if not winshift_ok then
	return vim.notify("Failed to load plugin `sindrets/winshift.nvim`")
end
winshift.setup()

local maximize_ok, maximize = pcall(require, "maximize")
if not maximize_ok then
	return vim.notify("Failed to load plugin `declancm/maximize.nvim`")
end
maximize.setup()

return maximize
