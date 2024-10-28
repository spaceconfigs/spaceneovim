local M = {}

M.setup = function()
	return require("infrastructure.adapters.lsp")
end

M.declaration = function(options)
	local adapter = M.setup()

	options = options or {}
	options.type = options.type or "local"

	adapter.declaration()
end

M.definition = function(options)
	local adapter = M.setup()

	options = options or {}
	options.type = options.type or "local"

	adapter.definition(options)
end

M.implementation = function(options)
	local adapter = M.setup()

	options = options or {}
	options.type = options.type or "local"

	adapter.implementation(options)
end

M.references = function(options)
	local adapter = M.setup()

	options = options or {}
	options.type = options.type or "local"

	adapter.references(options)
end

M.typedefinition = function(options)
	local adapter = M.setup()

	options = options or {}
	options.type = options.type or "local"

	adapter.typedefinition(options)
end

M.show_signature = function()
	local adapter = M.setup()

	adapter.show_signature()
end

M.show_documentation = function()
	local adapter = M.setup()

	adapter.show_documentation()
end

M.type_definition = function()
	local adapter = M.setup()

	adapter.type_definition()
end

M.show_code_action = function()
	local adapter = M.setup()

	adapter.show_code_action()
end

M.show_references = function()
	local adapter = M.setup()

	adapter.show_references()
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

M.code_action = function()
	local adapter = M.setup()

	adapter.show_code_action()
end

M.signature_help = function()
	local adapter = M.setup()

	adapter.show_signature()
end

M.get_symbol = function()
	local adapter = M.setup()

	adapter.get_symbol()
end

return M
