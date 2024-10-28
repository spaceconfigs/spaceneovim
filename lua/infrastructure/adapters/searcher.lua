local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.searcher")
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
}

return make_logged("adapters/searcher", M)
