local ok, plugin = pcall(require, "themery")
if not ok then
	return vim.notify("Failed to load plugin `zaldih/themery.nvim`")
end

local ok_nightfox = pcall(require, "themery")
local ok_tokyonigh = pcall(require, "tokyonight")
local ok_matrix = pcall(require, "matrix")
local ok_catppuccin = pcall(require, "catppuccin")

local themes = {}

if ok_nightfox then
	table.insert(themes, {
		name = "carbonfox",
		colorscheme = "carbonfox",
	})
end

if ok_tokyonigh then
	table.insert(themes, {
		name = "tokyonight",
		colorscheme = "tokyonight",
	})
end

if ok_matrix then
	table.insert(themes, {
		name = "matrix",
		colorscheme = "matrix",
	})
end

if ok_catppuccin then
	table.insert(themes, {
		name = "catppuccin",
		colorscheme = "catppuccin",
	})
end

plugin.setup({
	themes = themes,
})

return plugin
