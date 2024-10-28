local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.adapter_registry").hover()
end

M.toggle = function()
	local adapter = M.setup()

	adapter.toggle()
end

M.dismiss = function()
	local adapter = M.setup()

	adapter.dismiss()
end
return make_logged("usecases/hover", M)
