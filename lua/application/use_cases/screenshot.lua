local M = {}

M.setup = function()
	return require("infrastructure.adapters.screenshot")
end

M.capture = function(action, options)
	local adapter = M.setup()

	options = options or {}
	options.type = options.type or ""

	adapter.capture(action, options)
end

return M
