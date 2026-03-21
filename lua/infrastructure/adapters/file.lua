local M = {}

local logger_use_manage = require("application.use_cases.logger")
local file_util = require("infrastructure.utils.file")
local plugin = require("infrastructure.plugins.file")
local snacks = plugin.snacks

M.oldfiles = function(opts)
	local message = {
		module = "adapters/file",
		func = "oldfiles",
		opts = opts,
	}
	logger_use_manage.debug(message)

	snacks.picker.recent()
end

M.list = function(opts)
	local message = {
		module = "adapters/file",
		func = "list",
		opts = opts,
	}
	logger_use_manage.debug(message)

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
	logger_use_manage.debug(message)

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

return M
