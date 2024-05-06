return {
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		lazy = false,
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		lazy = false,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		lazy = false,
		dependencies = {
			{ "tpope/vim-dadbod" },
			{ "kristijanhusak/vim-dadbod-completion" },
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_use_nvim_notify = 1
		end,
	},
}
