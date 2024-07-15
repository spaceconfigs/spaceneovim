local vim = vim
local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.file")

local copy_item = function(opt)
	local full_path = vim.fn.expand(opt.wildcards)
	if opt.is_project then
		local handle = io.popen("git rev-parse --show-toplevel")
		local project_root_path = handle:read("*a")
		handle:close()

		local git_root = string.gsub(project_root_path, "%s+$", "")
		full_path = full_path:sub(#git_root + 2)
	end

	if opt.without_extention then
		full_path = full_path:match("(.+)%..+") or full_path
	end

	vim.fn.setreg("+", full_path)
end

M.oldfiles = function()
	local message = {
		module = "use_cases/file",
		func = "oldfiles",
	}
	logger_use_case.debug(message)

	adapter.oldfiles()
end

M.list = function(opts)
	return function()
		local message = {
			module = "use_cases/file",
			func = "list",
			opts = opts,
		}
		logger_use_case.debug(message)

		opts = opts or {}
		opts.location = opts.location or "project"

		if opts.location == "file" then
			adapter.list({
				path = vim.fn.expand("%:p:h"),
			})

			return
		end

		local cwd = vim.loop.cwd()
		local path = vim.fs.find(
			{ ".git", "package.json", "setup.py", "Makefile", "CMakeLists.txt" },
			{ upward = true, stop = vim.loop.os_homedir(), path = cwd }
		)[1]

		path = vim.fn.fnamemodify(path, ":h")
		adapter.list({
			path = path,
		})
	end
end

M.search = function()
	local message = {
		module = "use_cases/file",
		func = "search",
	}
	logger_use_case.debug(message)

	local path = vim.fn.expand("%:h")

	adapter.search({
		path = path,
	})
end

M.search_hover = function()
	local message = {
		module = "use_cases/file",
		func = "search_hover",
	}
	logger_use_case.debug(message)

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

	copy_item({ wildcards = "%:p" })
end

M.copy_project_path = function()
	local message = {
		module = "use_cases/file",
		func = "copy_project_path",
	}
	logger_use_case.debug(message)

	copy_item({
		is_project = true,
		wildcards = "%:p",
	})
end

M.copy_name = function()
	local message = {
		module = "use_cases/file",
		func = "copy_name",
	}
	logger_use_case.debug(message)

	copy_item({ wildcards = "%:t" })
end

M.copy_name_no_extention = function()
	local message = {
		module = "use_cases/file",
		func = "copy_name",
	}
	logger_use_case.debug(message)

	copy_item({
		without_extention = true,
		wildcards = "%:t",
	})
end

M.copy_folder_path = function()
	local message = {
		module = "use_cases/file",
		func = "copy_folder_path",
	}
	logger_use_case.debug(message)
	copy_item({ wildcards = "%:p:h" })
end

M.copy_project_folder_path = function()
	local message = {
		module = "use_cases/file",
		func = "copy_folder_path",
	}
	logger_use_case.debug(message)
	copy_item({
		is_project = true,
		wildcards = "%:p:h",
	})
end

return M
