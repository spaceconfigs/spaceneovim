local maximize_ok, maximize = pcall(require, "maximize")
if not maximize_ok then
	return vim.notify("Failed to load plugin `declancm/maximize.nvim`")
end

maximize.setup()

return maximize
