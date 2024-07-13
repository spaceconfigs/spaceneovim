local M = {}

local logger_use_manage = require("application.use_cases.logger")
local telescope = require("infraestrucuture.plugins.file")
local builtin = telescope.builtin

M.oldfiles = function()
	local message = {
		module = "adapters/file",
		func = "oldfiles",
	}
	logger_use_manage.debug(message)

	builtin.oldfiles({ show_line = false })
end

M.list = function(opts)
	local message = {
		module = "adapters/file",
		func = "list",
		opts = opts,
	}
	logger_use_manage.debug(message)

	local cwd = opts and opts.path or nil
	builtin.find_files({
		show_line = false,
		cwd = cwd,
	})
end

M.search = function(opts)
	local message = {
		module = "adapters/file",
		func = "search",
	}
	logger_use_manage.debug(message)

	opts = opts or {}

	if opts.text ~= nil and opts.text ~= "" then
		return builtin.grep_string({
			show_line = false,
			search = opts.text,
			search_dirs = {
				opts.path,
			},
		})
	end

	builtin.live_grep({
		show_line = false,
		search_dirs = {
			opts.path,
		},
	})
end

return M
