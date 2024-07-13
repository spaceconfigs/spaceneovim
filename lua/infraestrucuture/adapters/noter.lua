local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	return require("infraestrucuture.plugins.noter")
end

M.add = function()
	local message = {
		module = "adapters/noter",
		func = "add",
	}
	logger_use_manage.debug(message)
end

M.list = function()
	local message = {
		module = "adapters/noter",
		func = "list",
	}
	logger_use_manage.debug(message)
end

M.dismiss = function()
	local message = {
		module = "adapters/noter",
		func = "dismiss",
	}
	logger_use_manage.debug(message)
end

M.find = function()
	local message = {
		module = "adapters/noter",
		func = "find",
	}
	logger_use_manage.debug(message)

	vim.cmd("ObsidianSearch")
end

M.checkbox = function(action)
	local message = {
		module = "adapters/noter",
		func = "toggle_checkbox",
		action = action,
	}
	logger_use_manage.debug(message)

	if action == "toggle" then
		org.action("org_mappings.toggle_checkbox")
	end
end

M.todo = function(action)
	local message = {
		module = "adapters/noter",
		func = "todo",
		action = action,
	}
	logger_use_manage.debug(message)

	if action == "next_state" then
		org.action("org_mappings.todo_next_state")
	end
end

M.insert_heading = function(type)
	local message = {
		module = "adapters/noter",
		func = "insert_heading",
		type = type,
	}
	logger_use_manage.debug(message)

	if type == "same" then
		org.action("org_mappings.insert_heading_respect_content")
	end
end
return M
