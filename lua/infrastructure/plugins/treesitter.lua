local ok, plugin = pcall(require, "nvim-treesitter")
if not ok then
	error("Failed to load plugin `nvim-treesitter/nvim-treesitter`")
end

return plugin
