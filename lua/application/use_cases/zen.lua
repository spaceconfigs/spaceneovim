local M = {}

M.setup = function()
	return require("infrastructure.adapters.zen")
end

M.toggle = function()
	local adapter = M.setup()

	adapter.toggle()
end

M.center = function()
	local adapter = M.setup()

	adapter.center()
end

M.area = function()
	local adapter = M.setup()

	adapter.area()
end

return M
