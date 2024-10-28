local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("infrastructure.adapters.rest")
end

M.open = function()
	local adapter = M.setup()

	adapter.open()
end

M.send = function()
	local adapter = M.setup()

	adapter.send()
end

M.replay = function()
	local adapter = M.setup()

	adapter.replay()
end

return make_logged("use_cases/rest", M)
