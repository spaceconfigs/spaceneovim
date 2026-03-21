local vim = vim
local M = {}

local logger_use_case = require("application.use_cases.logger")
local file_util = require("infrastructure.utils.file")

M.setup = function()
	return require("infrastructure.adapters.file")
end

M.oldfiles = function(opts)
	return function()
		local message = {
			module = "use_cases/file",
			func = "oldfiles",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		opts = opts or {}
		opts.cwd_only = opts.cwd_only or false

		adapter.oldfiles(opts)
	end
end

M.list = function(opts)
	return function()
		local message = {
			module = "use_cases/file",
			func = "list",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		opts = opts or {}
		opts.location = opts.location or "file"
		opts.path = file_util.project(opts.location)
		opts.cwd_only = opts.cwd_only or false

		adapter.list({
			path = opts.path,
			cwd_only = opts.cwd_only,
		})
	end
end

M.search = function()
	local message = {
		module = "use_cases/file",
		func = "search",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.search({
		path = file_util.path(),
	})
end

M.search_hover = function()
	local message = {
		module = "use_cases/file",
		func = "search_hover",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	local path = vim.api.nvim_buf_get_name(0)
	local text = vim.fn.expand("<cword>")

	adapter.search({
		path = path,
		text = text,
	})
end

M.rename = function()
	local message = {
		module = "use_cases/file",
		func = "rename",
	}
	logger_use_case.debug(message)

	local new_name = vim.fn.input("New name: ")
	local buffer = vim.api.nvim_get_current_buf()
	local old_name = vim.api.nvim_buf_get_name(buffer)

	local success, err = os.rename(old_name, new_name)
	if not success then
		logger_use_case.error("Error renaming file: " .. err)
		return
	end

	vim.api.nvim_buf_set_name(buffer, new_name)
	vim.cmd("!w")
end

M.copy = function(opts)
	return function()
		opts = opts or {}
		opts.item = opts.item or "file"
		opts.location = opts.location or "root"
		opts.extensions = opts.extensions or "type"

		local message = {
			module = "use_cases/file",
			func = "copy_line",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		local result = adapter.copy(opts)
		logger_use_case.info("Copied " .. result)
	end
end

return M
