local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.adapter_registry").lsp()
end

---@param type "definition"|"implementation"|"references"|"typedefinition"
---@param options? { type?: string }
M.navigate = function(type, options)
	local adapter = M.setup()

	options = options or {}
	options.type = options.type or "local"

	adapter.navigate(type, options)
end

M.show_signature = function()
	local adapter = M.setup()

	adapter.show_signature()
end

M.show_documentation = function()
	local adapter = M.setup()

	adapter.show_documentation()
end

M.show_code_action = function()
	local adapter = M.setup()

	adapter.show_code_action()
end

M.format = function()
	local adapter = M.setup()

	adapter.format()
end

M.diagnostics = function()
	local adapter = M.setup()

	adapter.diagnostics()
end

M.info = function()
	local adapter = M.setup()

	adapter.info()
end

M.restart = function()
	local adapter = M.setup()

	adapter.restart()
end

M.rename = function()
	local adapter = M.setup()

	adapter.rename()
end

M.get_symbol = function()
	local adapter = M.setup()

	adapter.get_symbol()
end

return make_logged("usecases/lsp", M)
