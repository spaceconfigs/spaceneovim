local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").formatter()
end

M.format = function()
	local adapter = M.setup()

	adapter.format()
end

return make_logged("use_cases/formatter", M)
