local ok, plugin = pcall(require, "nvim-devdocs")
if not ok then
	return vim.notify("Failed to load plugin `luckasRanarison/nvim-devdoc`")
end

plugin.setup({
	previewer_cmd = "glow",
})

return plugin
