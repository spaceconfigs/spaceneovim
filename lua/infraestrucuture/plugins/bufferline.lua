local ok, plugin = pcall(require, "bufferline")
if not ok then
	return vim.notify("Failed to load plugin `akinsho/bufferline.nvim`")
end

plugin.setup({
	options = {
		show_buffer_close_icons = false,
		show_close_icon = false,
	},
})

return plugin
