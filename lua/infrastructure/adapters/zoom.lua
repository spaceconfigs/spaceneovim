local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.plugin_registry").zoom()
local gui_font_resize = plugin.gui_font_resize

---@type ZoomPort
local M = {
	change = function(opts)
		if opts.delta > 0 then
			return vim.cmd("GUIFontSizeUp 1")
		end

		if opts.delta < 0 then
			return vim.cmd("GUIFontSizeDown 1")
		end

		vim.cmd("GUIFontSizeSet")
	end,
}

return make_logged("adapters/zoom", M)
