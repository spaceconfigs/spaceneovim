return {
	{ "ThePrimeagen/vim-be-good", lazy = false },
	{
		"3rd/image.nvim",
		lazy = false,
		config = true,
		dependencies = {
			{
				"vhyrro/luarocks.nvim",
				priority = 1001,
				opts = {
					rocks = { "magick" },
				},
			},
		},
	},
	{ "HakonHarnes/img-clip.nvim", lazy = false },
	{ "norcalli/nvim-colorizer.lua", options = {}, lazy = false },
	{ "stevearc/dressing.nvim", options = {}, lazy = false },
	{ "xiyaowong/transparent.nvim", options = {}, lazy = false },
	{
		"jinh0/eyeliner.nvim",
		lazy = false,
		opts = {
			highlight_on_key = true,
			dim = true,
		},
	},
	{
		"LunarVim/bigfile.nvim",
		event = "BufRead",
		config = true,
	},
	{
		"kylechui/nvim-surround",
		event = "BufRead",
		config = true,
	},
	{
		"declancm/cinnamon.nvim",
		event = "BufRead",
		config = true,
	},
	{
		"tzachar/local-highlight.nvim",
		event = "BufRead",
		lazy = false,
	},
	-- {
	-- 	"goolord/alpha-nvim",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("alpha").setup(require("alpha.themes.startify").config)
	-- 	end,
	-- },
	{
		"hedyhli/outline.nvim",
		event = "BufRead",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	-- {
	-- 	"tris203/precognition.nvim",
	-- 	config = true,
	-- 	event = "BufRead",
	-- },
	{
		"m4xshen/hardtime.nvim",
		event = "BufRead",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			disabled_keys = {
				["<Up>"] = { "" },
				["<Down>"] = { "" },
				["<Left>"] = { "" },
				["<Right>"] = { "" },
			},
		},
	},
}
