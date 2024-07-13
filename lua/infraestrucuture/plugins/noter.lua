local ok, obsidian = pcall(require, "obsidian")
if not ok then
	return vim.notify("Failed to load plugin `epwalsh/obsidian.nvim`")
end

obsidian.setup({
	workspaces = {
		{
			name = "Notes",
			path = vim.fn.expand("~") .. "/Notes",
		},
	},
})

return obsidian
