local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.screenshot")

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

M.capture = function(action, options)
	local message = {
		module = "adapters/screenshot",
		func = "capture",
		action = action,
		options = options,
	}
	logger_use_case.debug(message)

	vim.cmd("normal! :<Esc>")

	local actions = capture_dispatch[action]
	local handler = actions[options.type] or actions.default
	handler()
end

return M
