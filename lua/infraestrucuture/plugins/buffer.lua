local outline_ok, outline = pcall(require, "outline")
local bufferline_ok, bufferline = pcall(require, "bufferline")
local bufdelete_ok, bufdelete = pcall(require, "bufdelete")

if not outline_ok then
	return vim.notify("Failed to load plugin `hedyhli/outline.nvim`")
end

outline.setup()

if not bufferline_ok then
	return vim.notify("Failed to load plugin `akinsho/bufferline.nvim`")
end

if not bufdelete_ok then
	return vim.notify("Failed to load plugin `famiu/bufdelete.nvim`")
end

bufferline.setup({
	options = {
		show_buffer_close_icons = false,
		show_close_icon = false,
	},
})

return {
	outline = outline,
	bufferline = bufferline,
	bufdelete = bufdelete,
}
