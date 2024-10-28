local M = {}

local logger_use_case = require("application.use_cases.logger")
local lsp_use_case = require("application.use_cases.lsp")

M.navigate = function(opts)
	return function()
		local message = {
			module = "controllers/lsp",
			func = "navigate",
			opts = opts,
		}
		logger_use_case.debug(message)
		lsp_use_case.navigate(opts.type, opts.options)
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
