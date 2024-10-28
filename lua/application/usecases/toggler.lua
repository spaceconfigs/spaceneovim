local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.adapter_registry").toggler()
end

M.number = function()
	local adapter = M.setup()

	adapter.number()
end

M.wrap = function()
	local adapter = M.setup()

	adapter.wrap()
end
return make_logged("usecases/toggler", M)
