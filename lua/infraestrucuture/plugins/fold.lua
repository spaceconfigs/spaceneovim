local ok, plugin = pcall(require, "ufo")
if not ok then
	return vim.notify("Failed to load plugin `kevinhwang91/nvim-ufo`")
end

-- Fold settings
vim.o.foldcolumn = "auto:9" -- Automatically adjust fold column width based on the number of folds
vim.o.foldlevel = 99 -- High value needed for ufo, adjust as needed
vim.o.foldlevelstart = 99 -- Start unfolded, adjust based on preference
vim.o.foldenable = true -- Enable folding by default
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

local filetypes = { "git", "NeogitStatus" }

plugin.setup({
	provider_selector = function(_, ft)
		return filetypes[ft] or { "treesitter", "indent" }
	end,
})

return plugin
