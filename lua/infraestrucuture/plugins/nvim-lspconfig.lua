local ok, plugin = pcall(require, "lspconfig")
if not ok then
	return vim.notify("Failed to load plugin `neovim/nvim-lspconfig`")
end

return plugin
