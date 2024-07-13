local M = {}

local ok, telescope = pcall(require, "telescope")
if not ok then
	return vim.notify("Failed to require package `telescope`")
end

local logger_use_manage = require("application.use_cases.logger")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		path_display = {
			-- shorten = {
			--   len = 3, exclude = { 1, -1 }
			-- },
			-- tail=true,
			truncate = true,
		},
		default_mappings = false,
		file_ignore_patterns = { ".git/", "node_modules/*" },
		mappings = {
			i = {
				["<DOWN>"] = actions.cycle_history_next,
				["<UP>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-h>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<CR>"] = actions.select_default,
				["<C-c>"] = actions.close,
			},
			n = {
				o = false,
				["<DOWN>"] = actions.cycle_history_next,
				["<UP>"] = actions.cycle_history_prev,
				["<C-n>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-h>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<CR>"] = actions.select_default,
				["<C-c>"] = actions.close,
				["?"] = actions.which_key,
			},
		},
	},
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
		grep_string = {
			layout_strategy = "vertical",
		},
		live_grep = {
			layout_strategy = "vertical",
		},
	},
	mappings = {
		i = {},
		n = {},
	},
	extensions = {
		{
			override_generic_sorter = true, -- override the generic sorter
			override_finder_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

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

M.lsp_document_symbols = function()
	local message = {
		module = "adapters/finder",
		func = "lsp_document_symbols",
	}
	logger_use_manage.debug(message)

	builtin.lsp_document_symbols({ show_line = false })
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
