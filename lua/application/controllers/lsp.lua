local M = {}

local logger_use_case = require("application.use_cases.logger")
local lsp_use_case = require("application.use_cases.lsp")

M.declaration = function(options)
	return function()
		local message = {
			module = "controllers/lsp",
			func = "declaration",
			options = options,
		}
		logger_use_case.debug(message)
		lsp_use_case.declaration(options)
	end
end

M.definition = function(options)
	return function()
		local message = {
			module = "controllers/lsp",
			func = "definition",
			options = options,
		}
		logger_use_case.debug(message)
		lsp_use_case.definition(options)
	end
end

M.implementation = function(options)
	return function()
		local message = {
			module = "controllers/lsp",
			func = "implementation",
			options = options,
		}
		logger_use_case.debug(message)
		lsp_use_case.implementation(options)
	end
end

M.references = function(options)
	return function()
		local message = {
			module = "controllers/lsp",
			func = "references",
			options = options,
		}
		logger_use_case.debug(message)
		lsp_use_case.references(options)
	end
end

M.typedefinition = function(options)
	return function()
		local message = {
			module = "controllers/lsp",
			func = "typedefinition",
			options = options,
		}
		logger_use_case.debug(message)
		lsp_use_case.typedefinition(options)
	end
end

M.show_signature = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "show_signature",
		}
		logger_use_case.debug(message)
		lsp_use_case.show_signature()
	end
end

M.show_documentation = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "show_documentation",
		}
		logger_use_case.debug(message)
		lsp_use_case.show_documentation()
	end
end

M.type_definition = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "type_definition",
		}
		logger_use_case.debug(message)
		lsp_use_case.type_definition()
	end
end

M.show_code_action = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "show_code_action",
		}
		logger_use_case.debug(message)
		lsp_use_case.show_code_action()
	end
end

M.show_references = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "show_references",
		}
		logger_use_case.debug(message)
		lsp_use_case.show_references()
	end
end

M.format = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "format",
		}
		logger_use_case.debug(message)
		lsp_use_case.format()
	end
end

M.diagnostics = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "diagnostics",
		}
		logger_use_case.debug(message)
		lsp_use_case.diagnostics()
	end
end

M.info = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "info",
		}
		logger_use_case.debug(message)
		lsp_use_case.info()
	end
end

M.restart = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "restart",
		}
		logger_use_case.debug(message)
		lsp_use_case.restart()
	end
end

M.rename = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "rename",
		}
		logger_use_case.debug(message)
		lsp_use_case.rename()
	end
end

M.code_action = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "code_action",
		}
		logger_use_case.debug(message)
		lsp_use_case.code_action()
	end
end

M.signature_help = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "signature_help",
		}
		logger_use_case.debug(message)
		lsp_use_case.signature_help()
	end
end

M.get_symbol = function()
	return function()
		local message = {
			module = "controllers/lsp",
			func = "get_symbol",
		}
		logger_use_case.debug(message)
		lsp_use_case.get_symbol()
	end
end

return M
