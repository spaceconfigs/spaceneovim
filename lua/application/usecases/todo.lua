local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.adapter_registry").todo()
end

M.list = function()
	local adapter = M.setup()

	adapter.list()
end

return make_logged("usecases/todo", M)
