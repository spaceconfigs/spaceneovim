local vim = vim

local ok, which_key = pcall(require, "which-key")
if not ok then
	return vim.notify("Failed to load plugin `folke/which-key.nvim`")
end

which_key.setup({
	---@type false | "classic" | "modern" | "helix"
	preset = "modern",
	delay = 1000,
	win = {
		padding = { 3, 3 }, -- extra window padding [top/bottom, right/left]
	},
	layout = {
		align = "center", -- align columns center
	},
})

return which_key
