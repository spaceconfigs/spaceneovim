local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").layout()
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
return make_logged("use_cases/layout", M)
