local M = {}

local ok, plugin = pcall(require, "telescope")
if not ok then
	return vim.notify("Failed to require load `nvim-telescope/telescope.nvim`")
end

local actions = require("telescope.actions")
plugin.setup({
	defaults = {
		path_display = {
			-- shorten = {
			--   len = 3, exclude = { 1, -1 }
			-- },
			-- tail=true,
			truncate = true,
		},
		default_mappings = false,
		file_ignore_patterns = { "node_modules/*" },
		mappings = {
			i = {
				["<S-DOWN>"] = actions.cycle_history_next,
				["<S-UP>"] = actions.cycle_history_prev,
				["<DOWN>"] = actions.move_selection_next,
				["<UP>"] = actions.move_selection_previous,
				["<C-h>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<CR>"] = actions.select_default,
			},
			n = {
				o = false,
				["<S-DOWN>"] = actions.cycle_history_next,
				["<S-UP>"] = actions.cycle_history_prev,
				["<DOWN>"] = actions.move_selection_next,
				["<UP>"] = actions.move_selection_previous,
				["<C-h>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<CR>"] = actions.select_default,
				["<Space>"] = actions.which_key,
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
		--		fzf = {
		--			fuzzy = true, -- false will only do exact matching
		--			override_generic_sorter = true, -- override the generic sorter
		--			override_file_sorter = true, -- override the file sorter
		--			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		--			-- the default case_mode is "smart_case"
		--		},
	},
})

-- telescope.load_extension("fzf")
plugin.load_extension("ui-select")
plugin.load_extension("frecency")

local result = {}
for key, value in pairs(plugin) do
	result[key] = value
end
result.builtin = require("telescope.builtin")

return result
