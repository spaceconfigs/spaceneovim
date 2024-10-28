local M = {}

M.setup = function()
	return require("infrastructure.adapters.zoom")
end

M.change = function(opts)
	opts = opts or {}
	opts.delta = opts.delta or 1

	local adapter = M.setup()

	adapter.change(opts)
end

return M
