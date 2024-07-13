local M = {}

local logger_use_manage = require("application.use_cases.logger")

local require_telescope = function()
	return require("infraestrucuture.plugins.file")
end

local require_workspaces = function()
	return require("infraestrucuture.plugins.workspaces")
end

M.open = function()
	local message = {
		module = "adapters/workspace",
		func = "open",
	}
	logger_use_manage.debug(message)

	require_workspaces()
	local telescope = require_telescope()
	telescope.load_extension("workspaces")

	telescope.extensions.workspaces.workspaces()
end

M.add = function(opts)
	local message = {
		module = "adapters/workspace",
		func = "add",
		opts = opts,
	}
	logger_use_manage.debug(message)

	local workspaces = require_workspaces()
	workspaces.add(opts.path)
end

M.files = function(opts)
	local message = {
		module = "adapters/workspace",
		func = "files",
		opts = opts,
	}
	logger_use_manage.debug(message)

	local telescope = require_telescope()
	telescope.builtin.git_files({
		show_untracked = true,
		show_line = false,
	})
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

	local telescope = require_telescope()
	if opts.text ~= "" and opts.text ~= nil then
		return telescope.builtin.grep_string({
			search = opts.text,
			cwd = opts.cwd,
		})
	end

	telescope.builtin.live_grep({
		show_line = false,
		cwd = opts.cwd,
	})
end

return M
