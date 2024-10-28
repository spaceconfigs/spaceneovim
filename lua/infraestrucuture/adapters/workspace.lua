local M = {}

local logger_use_manage = require("application.use_cases.logger")
local workspaces = require("infraestrucuture.plugins.workspaces")
local file_plugin = require("infraestrucuture.plugins.file")
local file_usecase = require("application.use_cases.file")

file_plugin.telescope.load_extension("workspaces")

M.open = function()
	local message = {
		module = "adapters/workspace",
		func = "open",
	}
	logger_use_manage.debug(message)

	file_plugin.telescope.extensions.workspaces.workspaces()
end

M.add = function(opts)
	local message = {
		module = "adapters/workspace",
		func = "add",
		opts = opts,
	}
	logger_use_manage.debug(message)

	workspaces.add(opts.path)
end

M.files = function(opts)
	local message = {
		module = "adapters/workspace",
		func = "files",
		opts = opts,
	}
	logger_use_manage.debug(message)

	file_usecase.list({ location = "profile" })()
end

M.search = function(opts)
	local message = {
		module = "adapters/workspace",
		func = "search",
		opts = opts,
	}
	logger_use_manage.debug(message)

	opts = opts or {}
	opts.cwd = opts.cwd or ""

	if opts.text ~= "" and opts.text ~= nil then
		return file_plugin.telescope.builtin.grep_string({
			search = opts.text,
			cwd = opts.cwd,
		})
	end

	file_plugin.telescope.builtin.live_grep({
		show_line = false,
		cwd = opts.cwd,
	})
end

return M
