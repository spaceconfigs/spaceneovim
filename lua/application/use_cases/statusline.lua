local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").statusline()
end

M.toggle = function()
	local adapter = M.setup()

	adapter.toggle()
end

return make_logged("use_cases/statusline", M)
