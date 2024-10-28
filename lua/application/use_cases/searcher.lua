local vim = vim
local M = {}
local make_logged = require("application.helpers.make_logged")

local file_util = require("infrastructure.utils.file")

M.setup = function()
	return require("infrastructure.adapters.searcher")
end

---@param opts? { cwd_only?: boolean }
M.oldfiles = function(opts)
	local adapter = M.setup()

	opts = opts or {}
	opts.cwd_only = opts.cwd_only or false

	adapter.oldfiles(opts)
end

---@param opts? { location?: "buffer"|"project"|"directory", in_live?: boolean }
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

---@param opts? { location?: "buffer"|"project" }
M.search_selection = function(opts)
	local adapter = M.setup()
	opts = opts or {}
	local location = opts.location or "buffer"

	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local lines = vim.fn.getregion(start_pos, end_pos, { type = vim.fn.visualmode() })
	local text = table.concat(lines, "\n")

	local path = file_util.path()

	if location == "project" then
		path = file_util.project(location)
	end

	adapter.search({
		location = location,
		path = path,
		text = text,
	})
end

---@param opts? { location?: "buffer"|"project"|"directory" }
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

---@param opts? table
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

return make_logged("use_cases/searcher", M)
