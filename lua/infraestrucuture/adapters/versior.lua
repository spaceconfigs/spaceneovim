local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.versior")

M.blame_line = function()
	local message = {
		module = "adapters/versior",
		func = "blame_line",
	}
	logger_use_manage.debug(message)

	plugin.gitsigns.blame_line()
end

M.open = function()
	local message = {
		module = "adapters/versior",
		func = "open",
	}
	logger_use_manage.debug(message)

	plugin.neogit.open()
end

M.stage_files = function()
	local message = {
		module = "adapters/versior",
		func = "stage_files",
	}
	logger_use_manage.debug(message)

	plugin.gitsigns.stage_buffer()
end

M.unstage_files = function()
	local message = {
		module = "adapters/versior",
		func = "unstage_files",
	}
	logger_use_manage.debug(message)

	plugin.gitsigns.undo_stage_hunk()
end

return M
