local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_ok then
	error("Failed to load plugin `nvim-tree/nvim-tree.lua`")
end

local api = require("nvim-tree.api")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
	error("Failed to load plugin `folke/snacks.nvim`")
end

return {
	nvim_tree = api,
	snacks = snacks,
}
