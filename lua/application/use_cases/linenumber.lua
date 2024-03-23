local M = {}

local logger_use_case = require("application.use_cases.logger")

M.toggle_absolute = function()
	local message = {
		module = "use_cases/linenumber",
		func = "toggle_absolute",
	}
	logger_use_case.debug(message)

	if vim.opt.number:get() then
		vim.opt.number = false
		return
	end

	vim.opt.number = true
end

M.toggle_relative = function()
	local message = {
		module = "use_cases/linenumber",
		func = "toggle_relative",
	}
	logger_use_case.debug(message)

	if vim.opt.relativenumber:get() then
		vim.opt.relativenumber = false
		return
	end

	vim.opt.relativenumber = true
end

return M
