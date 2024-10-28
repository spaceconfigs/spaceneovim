local ok, plugin = pcall(require, "cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

if not ok then
	return vim.notify("Failed to load plugin `cmp`")
end

if not luasnip_ok then
	return vim.notify("Failed to require package `luasnip`")
end

-- vim.g.vim_dadbod_completion_mark = ""

plugin.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "codeium" },
		{ name = "luasnip" },
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "orgmode" },
		{ name = "treesitter" },
	},
	window = {
		documentation = plugin.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr" },
		format = function(entry, item)
			local menu_icon = {
				treesitter = "",
				nvim_lsp = "λ",
				luasnip = "",
				buffer = "",
				path = "",
				codeium = "󰧑",
				orgmode = "",
				cmdline = "",
				git = "󰊢",
				["vim-dadbod-completion"] = "",
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	mapping = {
		["<DOWN>"] = plugin.mapping(plugin.mapping.select_next_item(), { "s", "i", "c" }),
		["<UP>"] = plugin.mapping(plugin.mapping.select_prev_item(), { "s", "i", "c" }),
		["<CR>"] = plugin.mapping(plugin.mapping.confirm(), { "s", "i" }),
		["<Esc>"] = plugin.mapping(plugin.mapping.close(), { "s", "i", "n", "c" }),
		["<Tab>"] = plugin.mapping(function(fallback)
			if plugin.visible() then
				plugin.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = plugin.mapping(function(fallback)
			if plugin.visible() then
				plugin.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	},
})

plugin.setup.filetype("gitcommit", {
	sources = plugin.config.sources({ {
		name = "git",
	} }, { {
		name = "buffer",
	} }),
})

plugin.setup.filetype("sql", {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
	},
})

plugin.setup.cmdline({ "/", "?" }, {
	mapping = plugin.mapping.preset.cmdline(),
	sources = { {
		name = "buffer",
	} },
})

plugin.setup.cmdline(":", {
	mapping = plugin.mapping.preset.cmdline(),
	sources = plugin.config.sources({ {
		name = "path",
	} }, { {
		name = "cmdline",
	} }),
})

return plugin
