return {
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
		"nvim-lualine/lualine.nvim",
		event = "BufRead",
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
		event = "BufRead",
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
	{
		"tris203/precognition.nvim",
		config = true,
		event = "BufRead",
	},
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
