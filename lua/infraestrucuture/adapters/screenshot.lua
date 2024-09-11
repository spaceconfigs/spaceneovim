local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.screenshot")

M.copy = function(options)
	local message = {
		module = "adapters/screenshot",
		func = "copy",
		options = options,
	}
	logger_use_manage.debug(message)

	vim.cmd("normal! :<Esc>")

	if options.type == "text" then
		return plugin.copy_ascii_snapshot()
	end

	if options.type == "select" then
		return plugin.highlight_mode_copy_into_clipboard()
	end

	plugin.copy_into_clipboard()
end

M.save = function()
	local message = {
		module = "adapters/screenshot",
		func = "save",
	}
	logger_use_manage.debug(message)

	vim.cmd("normal! :<Esc>")
	plugin.highlight_mode_save_snapshot()
end

return M
