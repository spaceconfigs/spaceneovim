local ok, plugin = pcall(require, "toggleterm")
if not ok then
	return vim.notify("Failed to load plugin `akinsho/toggleterm.nvim`")
end
plugin.setup()

return require("toggleterm.terminal").Terminal
