local M = {}

local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.layout")

M.list = function()
	plugin.load_session()
end

M.save = function()
	plugin.save_current_session()
end

M.reload = function()
	plugin.load_current_dir_session()
end

M.delete = function()
	plugin.delete_session()
end

M.previous = function()
	plugin.load_last_session()
end

M.rename = function()
	vim.fn.input("Rename: ")
end
return make_logged("adapters/layout", M)
