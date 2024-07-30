local ok_telescope, telescope = pcall(require, "telescope")
if not ok_telescope then
	return vim.notify("Failed to require load `nvim-telescope/telescope.nvim`")
end

local actions = require("telescope.actions")
telescope.setup({
	defaults = {
		-- sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
		path_display = {
			-- shorten = {
			--   len = 3, exclude = { 1, -1 }
			-- },
			-- tail=true,
			truncate = true,
		},
		default_mappings = false,
		file_ignore_patterns = { "^.git/" },
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
	-- file_sorter = function()
	-- 	return require("telescope.sorters").get_generic_fuzzy_sorter()
	-- end,
	pickers = {
		-- find_files = {
		-- 	theme = "dropdown",
		-- 	sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
		-- },
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
		smart_open = {
			match_algorithm = "fzf",
			-- disable_devicons = false,
		},
		frecency = {
			auto_validate = false,
			matcher = "fuzzy",
			-- path_display = { "filename_first" },
		},
	},
})

telescope.load_extension("ui-select")
telescope.load_extension("frecency")
telescope.load_extension("frecency")

local result = {}
for key, value in pairs(telescope) do
	result[key] = value
end
result.builtin = require("telescope.builtin")

local ok_fzf, fzf = pcall(require, "fzf-lua")
if not ok_fzf then
	return vim.notify("Failed to require load `ibhagwan/fzf-lua`")
end

return {
	telescope = result,
	fzf = fzf,
}
