local vim = vim
local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.file")

M.oldfiles = function()
	local message = {
		module = "use_cases/file",
		func = "oldfiles",
	}
	logger_use_case.debug(message)

	adapter.oldfiles()
end

M.list = function()
	local message = {
		module = "use_cases/file",
		func = "list",
	}
	logger_use_case.debug(message)
	local path = vim.fn.expand("%:p:h")

	adapter.list({
		path = path,
	})
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

return M
