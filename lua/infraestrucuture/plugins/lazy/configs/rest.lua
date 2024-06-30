return {
	{ "wet-sandwich/hyper.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
		opts = {
			rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
		},
	},
	{
		"rest-nvim/rest.nvim",
		dependencies = { "luarocks.nvim" },
	},
}
