local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.plugin_registry").searcher()
local snacks = plugin.snacks

---@type SearcherPort
local M = {
	search = function(opts)
		if opts.location == "project" then
			return snacks.picker.grep({
				live = opts.text == nil,
				search = opts.text,
				cwd = opts.path,
			})
		end

		if opts.location == "directory" then
			return snacks.picker.grep({
				live = opts.text == nil,
				search = opts.text,
				cwd = opts.path,
			})
		end

		snacks.picker.lines({
			layout = { preset = "nitaicharan_lines" },
			pattern = opts.text,
		})
	end,

	resume = function(opts)
		snacks.picker.resume()
	end,

	search_link_next = function()
		vim.fn.search("https\\?=\\?", "")
	end,

	search_link_previous = function()
		vim.fn.search("https\\?=\\?", "b")
	end,

	keymaps = function(opts)
		opts = opts or {}
		local prefix = opts.prefix
		if not prefix then
			return snacks.picker.keymaps()
		end

		-- Neovim exposes mapping lhs values with `<leader>` expanded to the
		-- configured leader character, so normalize the requested prefix before
		-- filtering Snacks' keymap items.
		prefix = vim.api.nvim_replace_termcodes(prefix, true, true, true)
		return snacks.picker.keymaps({
			transform = function(item)
				return item.item.lhs:sub(1, #prefix) == prefix and item or false
			end,
		})
	end,
}

return make_logged("adapters/searcher", M)
