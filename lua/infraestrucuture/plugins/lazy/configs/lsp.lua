return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = false,
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
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
}
