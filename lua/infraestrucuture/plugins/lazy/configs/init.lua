return {
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("nightfox")
			vim.cmd.colorscheme("carbonfox")
		end,
	},
	{
		"kylechui/nvim-surround",
		lazy = false,
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		opts = {},
	},
	{
		"declancm/cinnamon.nvim",
		lazy = false,
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		config = function()
			require("lualine").setup({
				options = {
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					globalstatus = true,
				},
			})
		end,
	},
	{
		"tzachar/local-highlight.nvim",
		lazy = false,
		opts = {},
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	{
		"folke/noice.nvim",
		lazy = false,
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
						style = "none",
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
		"hedyhli/outline.nvim",
		lazy = false,
	},
	{ "folke/neodev.nvim", lazy = false, opts = {} },
	{ "windwp/nvim-ts-autotag", lazy = false, config = true },
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
}
