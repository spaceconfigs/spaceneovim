local ok, plugin = pcall(require, "dbee")
if not ok then
	error("Failed to load plugin `stevearc/conform.nvim`")
end

plugin.setup()

return plugin
