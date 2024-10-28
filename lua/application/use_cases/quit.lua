local M = {}

M.setup = function()
	return require("infrastructure.adapters.quit")
end

M.all = function()
	local adapter = M.setup()

	adapter.all()
end

M.save_all = function()
	local adapter = M.setup()

	adapter.save_all()
end

return M
