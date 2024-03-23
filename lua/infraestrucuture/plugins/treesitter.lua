local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	return vim.notify("Failed to load plugin `nvim-treesitter/nvim-treesitter`")
end

treesitter.setup({
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"markdown",
		"html",
		"markdown_inline",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
	additional_vim_regex_highlighting = false,
})

return
