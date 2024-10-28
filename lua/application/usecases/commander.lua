local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.adapter_registry").commander()
end

M.find = function()
	local adapter = M.setup()

	adapter.find()
end

return make_logged("usecases/commander", M)
