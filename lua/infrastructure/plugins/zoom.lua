local gui_font_resize_ok, gui_font_resize = pcall(require, "gui-font-resize")
if not gui_font_resize_ok then
	error("Failed to load plugin `ktunprasert/gui-font-resize.nvim`")
end

return {
	gui_font_resize = gui_font_resize,
}
