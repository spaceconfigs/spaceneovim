local neogit_ok, plugin = pcall(require, "gitsigns")
if not neogit_ok then
	return vim.notify("Failed to load plugin `lewis6991/gitsigns.nvim`")
end
plugin.setup()

return plugin
