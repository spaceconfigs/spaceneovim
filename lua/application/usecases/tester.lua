local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").tester()
end

---@param opts? table
M.toggle = function(opts)
	opts = opts or {}

	local adapter = M.setup()

	adapter.toggle()
end

---@param opts? table
M.run = function(opts)
	opts = opts or {}

	local adapter = M.setup()

	adapter.run()
end

return make_logged("usecases/tester", M)
