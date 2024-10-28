local M = {}
local make_logged = require("application.helpers.make_logged")

local options = { absolute = "number", relative = "relativenumber" }

M.toggle = function(type)
	local opt = options[type]
	if vim.opt[opt]:get() then
		vim.opt[opt] = false
		return
	end

	vim.opt[opt] = true
end

return make_logged("use_cases/linenumber", M)
