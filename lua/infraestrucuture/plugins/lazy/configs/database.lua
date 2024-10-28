return {
	{
		"kristijanhusak/vim-dadbod-ui",
    cmd = "DBUI",
		dependencies = {
			{ "tpope/vim-dadbod" },
			{ "kristijanhusak/vim-dadbod-completion" },
			{ "hrsh7th/nvim-cmp" },
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_use_nvim_notify = 1
		end,
	},
}
