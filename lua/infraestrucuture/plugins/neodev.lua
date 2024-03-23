local ok, plugin = pcall(require, "neodev")
if not ok then
	return vim.notify("Failed to load plugin `neodev`")
end

plugin.setup({
	library = {
		plugins = {
			"nvim-dap-ui",
		},
		types = true,
	},
})
