local M = {}

local make_logged = require("application.helpers.make_logged")
local file_util = require("infrastructure.utils.file")
local plugin = require("infrastructure.plugins.file")
local snacks = plugin.snacks

M.oldfiles = function(opts)
	snacks.picker.recent()
end

M.list = function(opts)
	local cwd = opts and opts.path
	snacks.picker.smart({
		multi = { "files" },
		cwd = cwd,
	})
end

M.copy = function(opts)
	local path = file_util.get_path_from_file(opts.location)

	if opts.item == "directory" then
		path = vim.fn.fnamemodify(path, ":h")
		vim.fn.setreg("+", path)
		return path
	end

	local line = vim.fn.line(".")
	local column = vim.fn.col(".")

	local extentions_functions = {
		none = function()
			return path:match("(.+)%..+$") or path
		end,
		type = function()
			return path
		end,
		type_line = function()
			return string.format("%s:%s", path, line)
		end,
		type_line_column = function()
			return string.format("%s:%s:%s", path, line, column)
		end,
	}

	path = extentions_functions[opts.extensions]()
	vim.fn.setreg("+", path)

	return path
end

M.edit_config = function()
	vim.cmd("edit $MYVIMRC")
end

M.source_config = function()
	vim.cmd("source $MYVIMRC")
end

M.delete_current = function()
	vim.fn.delete(vim.fn.expand("%"))
	vim.cmd("bdelete!")
end

M.save = function()
	vim.cmd("write!")
end

M.save_all = function()
	vim.cmd("wall!")
end

return make_logged("adapters/file", M)
