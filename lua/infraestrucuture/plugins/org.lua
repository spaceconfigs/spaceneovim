local neogit_ok, plugin = pcall(require, "orgmode")
if not neogit_ok then
	return vim.notify("Failed to load plugin `nvim-orgmode/orgmode`")
end

plugin.setup()

return plugin
