return {
	{
		"folke/lazydev.nvim",
		config = true,
		ft = "lua",
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
	},
	{ "neovim/nvim-lspconfig" },
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{
		"folke/noice.nvim",
		event = "BufRead",
		opts = {
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
			},
			views = {
				cmdline_popup = {
					border = {
						style = "single",
						padding = { 2, 2 },
					},
					filter_options = {},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"windwp/nvim-ts-autotag",
		config = true,
	},
}
