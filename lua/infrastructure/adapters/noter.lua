local vim = vim
local M = {}

local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.noter")

M.new = function()
	vim.cmd("ObsidianNew")
end

M.list = function()
end

M.dismiss = function()
end

M.find = function()
	vim.cmd("ObsidianSearch")
end

M.checkbox = function(action)
	if not action == "toggle" then
		return
	end

	plugin.action("org_mappings.toggle_checkbox")
end

M.todo = function(action)
	if not action == "next_state" then
		return
	end

	plugin.action("org_mappings.todo_next_state")
end

M.insert_heading = function(type)
	if not type == "same" then
		return
	end

	plugin.action("org_mappings.insert_heading_respect_content")
end
return make_logged("adapters/noter", M)
