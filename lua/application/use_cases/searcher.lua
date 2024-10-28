local vim = vim
local M = {}

local file_util = require("infrastructure.utils.file")

M.setup = function()
	return require("infrastructure.adapters.searcher")
end

M.oldfiles = function(opts)
	local adapter = M.setup()

	opts = opts or {}
	opts.cwd_only = opts.cwd_only or false

	adapter.oldfiles(opts)
end

M.search = function(opts)
	local adapter = M.setup()
	local path = file_util.path()
	opts = opts or {}
	local location = opts.location or "buffer"
	local in_live = opts.in_live or false

	if location == "project" then
		path = file_util.project(location)
	end

	if location == "directory" then
		path = file_util.directory()
	end

	adapter.search({
		location = location,
		path = path,
		in_live = in_live,
	})
end

M.search_hover = function(opts)
	local adapter = M.setup()
	opts = opts or {}
	local location = opts.location or "buffer"

	local path = vim.api.nvim_buf_get_name(0)
	local text = vim.fn.expand("<cword>")

	if location == "project" then
		path = file_util.project(location)
	end

	if location == "directory" then
		path = file_util.directory()
	end

	adapter.search({
		location = location,
		path = path,
		text = text,
	})
end

M.resume = function(opts)
	local adapter = M.setup()

	adapter.resume()
end

M.search_link_next = function()
	local adapter = M.setup()

	adapter.search_link_next()
end

M.search_link_previous = function()
	local adapter = M.setup()

	adapter.search_link_previous()
end

return M
