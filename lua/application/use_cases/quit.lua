local M = {}

M.setup = function()
	return require("infrastructure.adapters.quit")
end

M.quit = function(opts)
	local adapter = M.setup()

	adapter.quit(opts)
end

return M
