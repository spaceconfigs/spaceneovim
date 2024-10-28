local M = {}

M.setup = function()
	return require("infrastructure.adapters.fold")
end

M.open = function(opts)
	opts = opts or {}
	opts.location = opts.location or "cursor"

	local adapter = M.setup()

	adapter.open(opts)
end

M.close = function(opts)
	opts = opts or {}
	opts.location = opts.location or "cursor"

	local adapter = M.setup()

	adapter.close(opts)
end

M.toggle = function(opts)
	opts = opts or {}
	opts.location = opts.location or "cursor"

	local adapter = M.setup()

	adapter.toggle(opts)
end

return M
