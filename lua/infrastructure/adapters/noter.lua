local vim = vim

local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.plugin_registry").noter()

---@type NoterPort
local M = {
	new = function()
		vim.cmd("ObsidianNew")
	end,
	list = function()
	end,
	dismiss = function()
	end,
	find = function()
		vim.cmd("ObsidianSearch")
	end,
	checkbox = function(action)
		if not action == "toggle" then
			return
		end

		plugin.action("org_mappings.toggle_checkbox")
	end,
	todo = function(action)
		if not action == "next_state" then
			return
		end

		plugin.action("org_mappings.todo_next_state")
	end,
	insert_heading = function(type)
		if not type == "same" then
			return
		end

		plugin.action("org_mappings.insert_heading_respect_content")
	end,
}

return make_logged("adapters/noter", M)
