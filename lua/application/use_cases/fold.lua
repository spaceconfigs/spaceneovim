local M = {}

M.setup = function()
	return require("infrastructure.adapters.fold")
end

M.fold = function(action, opts)
	opts = opts or {}
	opts.location = opts.location or "cursor"

	local adapter = M.setup()

	adapter.fold(action, opts)
end

return M
