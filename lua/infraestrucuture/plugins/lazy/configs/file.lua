return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-telescope/telescope.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-frecency.nvim",
			"kkharji/sqlite.lua",
			"nvim-tree/nvim-web-devicons",
			{
				"danielfalk/smart-open.nvim",
				dependencies = {
					"kkharji/sqlite.lua",
					{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
				},
			},
		},
	},
}
