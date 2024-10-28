local M = {}

M.setup = function()
	return require("infrastructure.adapters.layout")
end

M.list = function()
	local adapter = M.setup()

	adapter.list()
end

M.reload = function()
	local adapter = M.setup()

	adapter.reload()
end

M.save = function()
	local adapter = M.setup()

	adapter.save()
end

M.delete = function()
	local adapter = M.setup()

	adapter.delete()
end

M.rename = function()
	local adapter = M.setup()

	adapter.rename()
end

M.previous = function()
	local adapter = M.setup()

	adapter.previous()
end
return M
