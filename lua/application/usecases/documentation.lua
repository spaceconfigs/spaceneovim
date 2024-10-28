local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.adapter_registry").documentation()
end

M.open = function()
	local adapter = M.setup()

	adapter.open()
end

M.install = function()
	local adapter = M.setup()

	adapter.install()
end

M.remove = function()
	local adapter = M.setup()

	adapter.remove()
end

return make_logged("usecases/documentation", M)
