return {
	{
		"wet-sandwich/hyper.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		{
			"rest-nvim/rest.nvim",
			ft = "http",
			dependencies = {
				{
					"vhyrro/luarocks.nvim",
					priority = 1000,
					config = true,
					opts = {
						rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
					},
				},
			},
		},
	},
	{
		"BlackLight/nvim-http",
	},
}
