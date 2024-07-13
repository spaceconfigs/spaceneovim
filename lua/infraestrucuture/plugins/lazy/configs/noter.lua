return {
	{
		"nvim-orgmode/orgmode",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "Personal",
					path = vim.fn.expand("~") .. "/Notes",
				},
				{
					name = "Work",
					path = vim.fn.expand("~") .. "/Notes",
				},
			},
		},
	},
}
