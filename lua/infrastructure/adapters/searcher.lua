local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.searcher")
local snacks = plugin.snacks

M.search = function(opts)
	local message = {
		module = "adapters/searcher",
		func = "search",
		opts = opts,
	}
	logger_use_case.debug(message)

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
end

M.resume = function(opts)
	local message = {
		module = "adapters/searcher",
		func = "resume",
		opts = opts,
	}
	logger_use_case.debug(message)

	snacks.picker.resume()
end

M.search_link_next = function()
	local message = {
		module = "adapters/searcher",
		func = "search_link_next",
	}
	logger_use_case.debug(message)

	vim.fn.search("https\\?=\\?", "")
end

M.search_link_previous = function()
	local message = {
		module = "adapters/searcher",
		func = "search_link_previous",
	}
	logger_use_case.debug(message)

	vim.fn.search("https\\?=\\?", "b")
end

return M
