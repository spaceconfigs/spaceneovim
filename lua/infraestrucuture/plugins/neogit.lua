local neogit_ok, plugin = pcall(require, "neogit")
if not neogit_ok then
	return vim.notify("Failed to load plugin `NeogitOrg/neogit`")
end
plugin.setup()

return plugin
