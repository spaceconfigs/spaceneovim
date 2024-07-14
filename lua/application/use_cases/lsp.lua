local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.lsp")

M.setup = function()
	local message = {
		module = "use_cases/lsp",
		func = "setup",
	}
	logger_use_case.debug(message)

  adapter.setup()
end

M.go_declaration = function()
	local message = {
		module = "use_cases/lsp",
		func = "go_declaration",
	}
	logger_use_case.debug(message)

	adapter.go_declaration()
end

M.go_definition = function()
	local message = {
		module = "use_cases/lsp",
		func = "go_definition",
	}
	logger_use_case.debug(message)

	adapter.go_definition()
end

M.go_implementation = function()
	local message = {
		module = "use_cases/lsp",
		func = "go_implementation",
	}
	logger_use_case.debug(message)

	adapter.go_implementation()
end

M.go_references = function()
	local message = {
		module = "use_cases/lsp",
		func = "go_references",
	}
	logger_use_case.debug(message)

	adapter.go_references()
end

M.go_typedefinition = function()
	local message = {
		module = "use_cases/lsp",
		func = "go_typedefinition",
	}
	logger_use_case.debug(message)

	adapter.go_typedefinition()
end

M.show_signature = function()
	local message = {
		module = "use_cases/lsp",
		func = "show_signature",
	}
	logger_use_case.debug(message)

	adapter.show_signature()
end

M.show_documentation = function()
	local message = {
		module = "use_cases/lsp",
		func = "show_documentation",
	}
	logger_use_case.debug(message)

	adapter.show_documentation()
end

M.type_definition = function()
	local message = {
		module = "use_cases/lsp",
		func = "type_definition",
	}
	logger_use_case.debug(message)

	adapter.type_definition()
end

M.show_code_action = function()
	local message = {
		module = "use_cases/lsp",
		func = "show_code_action",
	}
	logger_use_case.debug(message)

	adapter.show_code_action()
end

M.show_references = function()
	local message = {
		module = "use_cases/lsp",
		func = "show_references",
	}
	logger_use_case.debug(message)

	adapter.show_references()
end

M.format = function()
	local message = {
		module = "use_cases/lsp",
		func = "format",
	}
	logger_use_case.debug(message)

	adapter.format()
end

return M
