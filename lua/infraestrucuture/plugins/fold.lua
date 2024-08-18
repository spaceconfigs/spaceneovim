local ok, plugin = pcall(require, "pretty-fold")
if not ok then
	return vim.notify("Failed to load plugin `anuvyklack/pretty-fold.nvim`")
end

plugin.setup()

return plugin
