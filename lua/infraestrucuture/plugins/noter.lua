local ok, obsidian = pcall(require, "obsidian")
if not ok then
	return vim.notify("Failed to load plugin `epwalsh/obsidian.nvim`")
end

obsidian.setup({
	ui = { enable = false },
	workspaces = {
		{
			name = "Personal",
			path = vim.fn.expand("~") .. "/Notes",
		},
	},
})

return obsidian
