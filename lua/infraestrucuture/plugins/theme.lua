local ok, plugin = pcall(require, "themery")
if not ok then
	return vim.notify("Failed to load plugin `zaldih/themery.nvim`")
end

local ok_nightfox = pcall(require, "themery")
local ok_tokyonigh = pcall(require, "tokyonight")

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

plugin.setup({
	themes = themes,
})

return plugin
