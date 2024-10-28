local M = {}

local ok, telescope = pcall(require, "telescope")
if not ok then
	return vim.notify("Failed to require package `telescope`")
end

local logger_use_manage = require("application.use_cases.logger")
local actions = require("telescope.actions")

telescope.load_extension("ui-select")
telescope.load_extension("frecency")

local builtin = require("telescope.builtin")

M.diagnostics = function()
	local message = {
		module = "adapters/finder",
		func = "diagnostics",
	}
	logger_use_manage.debug(message)

	builtin.diagnostics({ show_line = false })
end

M.keymaps = function()
	local message = {
		module = "adapters/finder",
		func = "keymaps",
	}
	logger_use_manage.debug(message)

	builtin.keymaps({ show_line = false })
end

M.live_grep = function()
	local message = {
		module = "adapters/finder",
		func = "live_grep",
	}
	logger_use_manage.debug(message)

	builtin.live_grep({ show_line = false })
end

M.grep = function(opts)
	local message = {
		module = "adapters/finder",
		func = "grep",
		opts = opts,
	}
	logger_use_manage.debug(message)

	opts = opts or {}
	local show_line = opts.show_line or false
	local search = opts.text
	local finders = opts.files or {}

	builtin.grep_string({
		show_line = show_line,
		search = search,
		search_dirs = finders,
	})
end

M.help_tags = function()
	local message = {
		module = "adapters/finder",
		func = "help_tags",
	}
	logger_use_manage.debug(message)

	builtin.help_tags({ show_line = false })
end

M.lsp_references = function()
	local message = {
		module = "adapters/finder",
		func = "lsp_references",
	}
	logger_use_manage.debug(message)

	builtin.lsp_references({ show_line = false })
end

M.lsp_definitions = function()
	local message = {
		module = "adapters/finder",
		func = "lsp_definitions",
	}
	logger_use_manage.debug(message)

	builtin.lsp_definitions({ show_line = false })
end

M.lsp_implementations = function()
	local message = {
		module = "adapters/finder",
		func = "lsp_implementations",
	}
	logger_use_manage.debug(message)

	builtin.lsp_implementations({ show_line = false })
end

M.man_pages = function()
	local message = {
		module = "adapters/finder",
		func = "man_pages",
	}
	logger_use_manage.debug(message)
end

return M
