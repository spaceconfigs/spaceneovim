local vim = vim
local M = {}

local logger_use_case = require("application.use_cases.logger")
local file_util = require("infraestrucuture.utils.file")

M.setup = function()
	return require("infraestrucuture.adapters.file")
end

local copy_item = function(options)
	local full_path = vim.fn.expand(options.wildcards)
	if options.is_project then
		local handle = io.popen("git rev-parse --show-toplevel")
		local project_root_path = handle:read("*a")
		handle:close()

		local git_root = string.gsub(project_root_path, "%s+$", "")
		full_path = full_path:sub(#git_root + 2)
	end

	if options.without_extention then
		full_path = full_path:match("(.+)%..+") or full_path
	end

	vim.fn.setreg("+", full_path)
	return full_path
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
		opts.path = file_util.pwd(opts)
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

M.copy_path = function()
	local message = {
		module = "use_cases/file",
		func = "copy_path",
	}
	logger_use_case.debug(message)

	local result = copy_item({ wildcards = "%:p" })
	vim.notify("Copied " .. result)
end

M.copy_project_path = function()
	local message = {
		module = "use_cases/file",
		func = "copy_project_path",
	}
	logger_use_case.debug(message)

	local result = copy_item({
		is_project = true,
		wildcards = "%:p",
	})
	vim.notify("Copied " .. result)
end

M.copy_name = function()
	local message = {
		module = "use_cases/file",
		func = "copy_name",
	}
	logger_use_case.debug(message)

	local result = copy_item({ wildcards = "%:t" })
	vim.notify("Copied " .. result)
end

M.copy_name_no_extention = function()
	local message = {
		module = "use_cases/file",
		func = "copy_name",
	}
	logger_use_case.debug(message)

	local result = copy_item({
		without_extention = true,
		wildcards = "%:t",
	})
	vim.notify("Copied " .. result)
end

M.copy_folder_path = function()
	local message = {
		module = "use_cases/file",
		func = "copy_folder_path",
	}
	logger_use_case.debug(message)

	local result = copy_item({ wildcards = "%:p:h" })
	vim.notify("Copied " .. result)
end

M.copy_project_folder_path = function()
	local message = {
		module = "use_cases/file",
		func = "copy_folder_path",
	}
	logger_use_case.debug(message)

	local result = copy_item({
		is_project = true,
		wildcards = "%:p:h",
	})
	vim.notify("Copied " .. result)
end

return M
