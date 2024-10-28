local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	return vim.notify("Failed to load plugin `nvim-treesitter/nvim-treesitter`")
end

treesitter.setup({
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = { query = "@function.outer", desc = "Select around function" },
				["if"] = { query = "@function.inner", desc = "Select inside function" },
				["ac"] = { query = "@class.outer", desc = "Select around class" },
				["ic"] = { query = "@class.inner", desc = "Select inside class" },

				["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
				["i="] = { query = "@assignment.inner", desc = "Select inside part of an assignment" },

				-- ['=l'] = { query = '@assignment.lhs', desc = 'Select left-hand side of assignment' },
				-- ['=r'] = { query = '@assignment.rhs', desc = 'Select right-hand side of assignment' },

				["lhs"] = { query = "@assignment.lhs", desc = "Select left-hand side of assignment" },
				["rhs"] = { query = "@assignment.rhs", desc = "Select right-hand side of assignment" },

				["aa"] = { query = "@parameter.outer", desc = "Select around parameter/argument" },
				["ia"] = { query = "@parameter.inner", desc = "Select inside parameter/argument" },

				["ax"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
				["ix"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
			},
		},
		-- move = {
		-- 	enable = true,
		-- 	set_jumps = true, -- whether to set jumps in the jumplist
		-- 	goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
		-- 	goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
		-- 	goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
		-- 	goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
		-- },
		-- swap = {
		-- 	enable = true,
		-- 	swap_next = { ["<leader>>"] = "@parameter.inner" },
		-- 	swap_previous = { ["<leader><"] = "@parameter.outer" },
		-- },
		-- lsp_interop = {
		-- 	enable = true,
		-- 	peek_definition_code = {
		-- 		["gD"] = "@function.outer",
		-- 	},
		-- },
	},
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"markdown",
		"html",
		"markdown_inline",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
	additional_vim_regex_highlighting = false,
})

return
