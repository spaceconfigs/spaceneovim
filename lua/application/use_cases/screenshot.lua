local M = {}

M.setup = function()
	return require("infrastructure.adapters.screenshot")
end

M.copy = function(options)
	local adapter = M.setup()

	options = options or {}
	options.type = options.type or ""

	adapter.copy(options)
end

M.save = function(options)
	local adapter = M.setup()

	options = options or {}
	options.type = options.type or ""

	adapter.save(options)
end

return M
