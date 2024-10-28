local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").bookmarker()
end

M.add = function()
	local adapter = M.setup()

	adapter.add()
end

M.remove = function()
	local adapter = M.setup()

	adapter.remove()
end

M.remove_all = function()
	local adapter = M.setup()

	adapter.remove_all()
end

M.list = function()
	local adapter = M.setup()

	adapter.list()
end

return make_logged("use_cases/bookmarker", M)
