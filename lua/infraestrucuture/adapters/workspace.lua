local M = {}

local logger_use_manage = require("application.use_cases.logger")
local workspaces = require("infraestrucuture.plugins.workspaces")
local file = require("infraestrucuture.plugins.file")
file.load_extension("workspaces")

M.open = function()
	local message = {
		module = "adapters/workspace",
		func = "open",
	}
	logger_use_manage.debug(message)

	file.extensions.workspaces.workspaces()
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

	file.builtin.git_files({
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

	if opts.text ~= "" and opts.text ~= nil then
		return file.builtin.grep_string({
			search = opts.text,
			cwd = opts.cwd,
		})
	end

	file.builtin.live_grep({
		show_line = false,
		cwd = opts.cwd,
	})
end

return M
