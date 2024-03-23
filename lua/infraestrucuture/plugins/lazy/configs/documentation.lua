return {
	{
		"luckasRanarison/nvim-devdocs",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{ "nvim-treesitter/nvim-treesitter" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
