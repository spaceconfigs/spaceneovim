local M = {}
local make_logged = require("application.helpers.make_logged")

local lsp_adapter = require("application.ports.registry").lsp()
local file_util = require("application.ports.registry").file_util()
local file_use_case = require("application.use_cases.file")

M.setup = function()
	return require("application.ports.registry").workspace()
end

M.add = function()
	local adapter = M.setup()
	local editor = require("application.ports.registry").editor()
	local path = editor.cwd()

	adapter.add({ path = path })
end

M.open = function()
	local adapter = M.setup()

	adapter.open()
end

M.files = function()
	local adapter = M.setup()

	-- adapter.files()
	file_use_case.list({ location = "profile" })
end

M.grep_input = function()
	local adapter = M.setup()
	local editor = require("application.ports.registry").editor()

	local path = file_util.project("project")
	local text = editor.prompt("Grep symbol: ")

	adapter.search({ cwd = path, text = text })
end

M.diagnostics = function()
	local adapter = M.setup()

	lsp_adapter.diagnostics()
end

M.add_and_toggle_tree = function()
	local tree_use_case = require("application.use_cases.tree")
	M.add()
	tree_use_case.toggle()
end

return make_logged("use_cases/workspace", M)
