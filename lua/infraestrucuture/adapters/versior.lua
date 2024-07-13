local M = {}

local logger_use_manage = require("application.use_cases.logger")

local require_gitsigns = function()
	return require("infraestrucuture.plugins.gitsigns")
end

local require_neogit = function()
	return require("infraestrucuture.plugins.neogit")
end

M.blame_line = function()
	local message = {
		module = "adapters/versior",
		func = "blame_line",
	}
	logger_use_manage.debug(message)

	local gitsigns = require_gitsigns()
	gitsigns.blame_line()
end

M.open = function()
	local message = {
		module = "adapters/versior",
		func = "open",
	}
	logger_use_manage.debug(message)

	local neogit = require_neogit()
	neogit.open()
end

M.stage_files = function()
	local message = {
		module = "adapters/versior",
		func = "stage_files",
	}
	logger_use_manage.debug(message)

	local gitsigns = require_gitsigns()
	gitsigns.stage_buffer()
end

M.unstage_files = function()
	local message = {
		module = "adapters/versior",
		func = "unstage_files",
	}
	logger_use_manage.debug(message)

	local gitsigns = require_gitsigns()
	gitsigns.undo_stage_hunk()
end

return M
