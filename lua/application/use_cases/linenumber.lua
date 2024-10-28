local M = {}

local options = { absolute = "number", relative = "relativenumber" }

M.toggle = function(type)
	local opt = options[type]
	if vim.opt[opt]:get() then
		vim.opt[opt] = false
		return
	end

	vim.opt[opt] = true
end

return M
