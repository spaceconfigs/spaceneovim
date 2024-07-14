local ok, plugin = pcall(require, "codesnap")
if not ok then
	return vim.notify("Failed to load plugin `mistricky/codesnap.nvim/`")
end

plugin.setup({
	mac_window_bar = false,
	-- title = "CodeSnap.nvim",
	bg_color = "#101010",
	has_breadcrumbs = true,
	has_line_number = true,
	show_workspace = true,
	bg_padding = 10,
	save_path = "~/",
})

return plugin
