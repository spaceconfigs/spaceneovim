local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.file")

M.oldfiles = function(opts)
	local message = {
		module = "adapters/file",
		func = "oldfiles",
		opts = opts,
	}
	logger_use_manage.debug(message)

	plugin.telescope.builtin.oldfiles({ show_line = false, cwd_only = opts.cwd_only })
end

M.list = function(opts)
	local message = {
		module = "adapters/file",
		func = "list",
		opts = opts,
	}
	logger_use_manage.debug(message)

	local cwd = opts and opts.path

	-- plugin.fzf.files({ prompt = "LS> ", cwd = cwd })
	plugin.telescope.builtin.find_files({
		hidden = true,
		show_line = false,
		cwd = cwd,
	})
	-- plugins.telescope.extensions.smart_open.smart_open({
	-- 	show_line = false,
	-- 	cwd_only = opts.cwd_only,
	-- })
end

M.search = function(opts)
	local message = {
		module = "adapters/file",
		func = "search",
	}
	logger_use_manage.debug(message)

	opts = opts or {}

	if opts.text ~= nil and opts.text ~= "" then
		return plugin.telescope.builtin.grep_string({
			show_line = false,
			search = opts.text,
			search_dirs = {
				opts.path,
			},
		})
	end

	plugin.telescope.builtin.live_grep({
		show_line = false,
		search_dirs = {
			opts.path,
		},
	})
end

return M
