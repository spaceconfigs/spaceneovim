local ok, plugin = pcall(require, "hyper")
if not ok then
	return vim.notify("Failed to load plugin `natecraddock/workspaces.nvim`")
end

plugin.setup()

return require("hyper.view")
