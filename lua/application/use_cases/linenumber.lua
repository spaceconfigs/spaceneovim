local M = {}
local make_logged = require("application.helpers.make_logged")

local options = { absolute = "number", relative = "relativenumber" }

---@param type "absolute"|"relative"
M.toggle = function(type)
	local editor = require("application.ports.registry").editor()

	editor.toggle_option(options[type])
end

return make_logged("use_cases/linenumber", M)
