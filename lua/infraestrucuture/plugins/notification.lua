local ok, plugin = pcall(require, "notify")
if not ok then
	return vim.notify("Failed to load plugin `rcarriga/nvim-notify`")
end

plugin.setup()

return plugin
