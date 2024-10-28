local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.zoom")
local gui_font_resize = plugin.gui_font_resize

M.change = function(opts)
	local message = {
		module = "adapters/zoom",
		func = "change",
		opts = opts,
	}
	logger_use_manage.debug(message)

	if opts.delta > 0 then
		return vim.cmd("GUIFontSizeUp 1")
	end

	if opts.delta < 0 then
		return vim.cmd("GUIFontSizeDown 1")
	end

	vim.cmd("GUIFontSizeSet")
end

return M
