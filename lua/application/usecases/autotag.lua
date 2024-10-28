local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	local adapter = require("application.ports.adapter_registry").autotag()

	adapter.setup()
end

return make_logged("usecases/autotag", M)
