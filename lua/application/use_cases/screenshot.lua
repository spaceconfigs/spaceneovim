local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").screenshot()
end

---@param action "copy"|"save"
---@param options? { type?: ""|"select"|"text" }
M.capture = function(action, options)
	local adapter = M.setup()

	options = options or {}
	options.type = options.type or ""

	adapter.capture(action, options)
end

return make_logged("use_cases/screenshot", M)
