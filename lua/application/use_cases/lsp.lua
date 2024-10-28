local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	local message = {
		module = "use_cases/lsp",
		func = "setup",
	}
	logger_use_case.debug(message)

	return require("infraestrucuture.adapters.lsp")
end

M.declaration = function(options)
	return function()
		local message = {
			module = "use_cases/lsp",
			func = "declaration",
			options = options,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		options = options or {}
		options.type = options.type or "local"

		adapter.declaration()
	end
end

M.definition = function(options)
	return function()
		local message = {
			module = "use_cases/lsp",
			func = "definition",
			options = options,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		options = options or {}
		options.type = options.type or "local"

		adapter.definition(options)
	end
end

M.implementation = function(options)
	return function()
		local message = {
			module = "use_cases/lsp",
			func = "implementation",
			options = options,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		options = options or {}
		options.type = options.type or "local"

		adapter.implementation(options)
	end
end

M.references = function(options)
	return function()
		local message = {
			module = "use_cases/lsp",
			func = "references",
			options = options,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		options = options or {}
		options.type = options.type or "local"

		adapter.references(options)
	end
end

M.typedefinition = function(options)
	return function()
		local message = {
			module = "use_cases/lsp",
			func = "typedefinition",
			options = options,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		options = options or {}
		options.type = options.type or "local"

		adapter.typedefinition(options)
	end
end

M.show_signature = function()
	local message = {
		module = "use_cases/lsp",
		func = "show_signature",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.show_signature()
end

M.show_documentation = function()
	local message = {
		module = "use_cases/lsp",
		func = "show_documentation",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.show_documentation()
end

M.type_definition = function()
	local message = {
		module = "use_cases/lsp",
		func = "type_definition",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.type_definition()
end

M.show_code_action = function()
	local message = {
		module = "use_cases/lsp",
		func = "show_code_action",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.show_code_action()
end

M.show_references = function()
	local message = {
		module = "use_cases/lsp",
		func = "show_references",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.show_references()
end

M.format = function()
	local message = {
		module = "use_cases/lsp",
		func = "format",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.format()
end

M.diagnostics = function()
	local message = {
		module = "use_cases/lsp",
		func = "diagnostics",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.diagnostics()
end

M.info = function()
	local message = {
		module = "use_cases/lsp",
		func = "info",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.info()
end

M.get_symbol = function()
	local message = {
		module = "use_cases/get_symbol",
		func = "info",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.get_symbol()
end

return M
