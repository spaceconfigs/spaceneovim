local M = {}

M.setup = function()
	return require("infrastructure.adapters.tester")
end

M.toggle = function(opts)
	opts = opts or {}

	local adapter = M.setup()

	adapter.toggle()
end

M.run = function(opts)
	opts = opts or {}

	local adapter = M.setup()

	adapter.run()
end

return M
