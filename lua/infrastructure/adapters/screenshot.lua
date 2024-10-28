local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.plugin_registry").screenshot()

local capture_dispatch = {
	copy = {
		text = function() plugin.copy_ascii_snapshot() end,
		select = function() plugin.highlight_mode_copy_into_clipboard() end,
		default = function() plugin.copy_into_clipboard() end,
	},
	save = {
		select = function() plugin.highlight_mode_save_snapshot() end,
		default = function() plugin.save_snapshot() end,
	},
}

---@type ScreenshotPort
local M = {
	capture = function(action, options)
		vim.cmd("normal! :<Esc>")

		local actions = capture_dispatch[action]
		local handler = actions[options.type] or actions.default
		handler()
	end,
}

return make_logged("adapters/screenshot", M)
