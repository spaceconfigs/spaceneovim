local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").jumper()
end

---@param options? table
M.timer = function(options)
	local adapter = M.setup()
	options = options or {}

	adapter.timer(options)
end

M.words = function()
	local adapter = M.setup()

	adapter.words()
end

M.lines = function()
	local adapter = M.setup()

	adapter.lines()
end

M.remote = function()
	local adapter = M.setup()

	adapter.remote()
end
return make_logged("use_cases/jumper", M)
