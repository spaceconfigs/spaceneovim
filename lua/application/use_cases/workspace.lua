local M = {}

local logger_use_case = require("application.use_cases.logger")
local lsp_adapter = require("infrastructure.adapters.lsp")
local file_usecase = require("application.use_cases.file")

M.setup = function()
	return require("infrastructure.adapters.workspace")
end

-- TODO: change it to use `get_path` of utils module
local function find_project_path()
	local message = {
		module = "use_cases/workspace",
		func = "find_project_path",
	}
	logger_use_case.debug(message)

	local handle = io.popen("git rev-parse --show-toplevel")
	local project_root_path = handle:read("*a")
	handle:close()

	return string.gsub(project_root_path, "%s+$", "")
end

M.add = function()
	local message = {
		module = "use_cases/workspace",
		func = "add",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()
	local path = vim.loop.cwd()

	adapter.add({ path = path })
end

M.open = function()
	local message = {
		module = "use_cases/workspace",
		func = "open",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.open()
end

M.files = function()
	local message = {
		module = "use_cases/workspace",
		func = "files",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	-- adapter.files()
	file_usecase.list({ location = "profile" })()
end

M.grep_input = function()
	local message = {
		module = "use_cases/workspace",
		func = "grep_input",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	local path = find_project_path()
	local text = vim.fn.input("Grep symbol: ")

	adapter.search({ cwd = path, text = text })
end

M.diagnostics = function()
	local message = {
		module = "use_cases/workspace",
		func = "diagnostics",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	lsp_adapter.diagnostics()
end

M.add_and_toggle_tree = function()
	return function()
		local message = {
			module = "use_cases/workspace",
			func = "add_and_toggle_tree",
		}
		logger_use_case.debug(message)

		local tree_use_case = require("application.use_cases.tree")
		M.add()
		tree_use_case.toggle()()
	end
end

return M
