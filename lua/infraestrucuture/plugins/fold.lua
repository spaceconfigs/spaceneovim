local ok, plugin = pcall(require, "ufo")
if not ok then
	return vim.notify("Failed to load plugin `kevinhwang91/nvim-ufo`")
end

vim.o.foldcolumn = 'auto:9'
-- vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

plugin.setup()

return plugin
