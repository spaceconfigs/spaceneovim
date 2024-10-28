local M = {}

local logger_use_case = require("application.use_cases.logger")
local file_util = require("infrastructure.utils.file")
local plugin = require("infrastructure.plugins.file")
local snacks = plugin.snacks

M.oldfiles = function(opts)
	local message = {
		module = "adapters/file",
		func = "oldfiles",
		opts = opts,
	}
	logger_use_case.debug(message)

	snacks.picker.recent()
end

M.list = function(opts)
	local message = {
		module = "adapters/file",
		func = "list",
		opts = opts,
	}
	logger_use_case.debug(message)

	local cwd = opts and opts.path
	snacks.picker.smart({
		multi = { "files" },
		cwd = cwd,
	})
end

M.copy = function(opts)
	local message = {
		module = "adapters/file",
		func = "copy",
		opts = opts,
	}
	logger_use_case.debug(message)

	local path = file_util.get_path_from_file(opts.location)

	if not opts.item == "file" then
		return path
	end

	local line = vim.fn.line(".")
	local column = vim.fn.col(".")

	local extentions_functions = {
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
	local message = {
		module = "adapters/file",
		func = "edit_config",
	}
	logger_use_case.debug(message)

	vim.cmd("edit $MYVIMRC")
end

M.source_config = function()
	local message = {
		module = "adapters/file",
		func = "source_config",
	}
	logger_use_case.debug(message)

	vim.cmd("source $MYVIMRC")
end

M.delete_current = function()
	local message = {
		module = "adapters/file",
		func = "delete_current",
	}
	logger_use_case.debug(message)

	vim.fn.delete(vim.fn.expand("%"))
	vim.cmd("bdelete!")
end

M.save = function()
	local message = {
		module = "adapters/file",
		func = "save",
	}
	logger_use_case.debug(message)

	vim.cmd("write!")
end

M.save_all = function()
	local message = {
		module = "adapters/file",
		func = "save_all",
	}
	logger_use_case.debug(message)

	vim.cmd("wall!")
end

return M
