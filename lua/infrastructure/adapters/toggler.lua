local make_logged = require("application.helpers.make_logged")

---@type TogglerAdapter
local M = {
	number = function()
		vim.cmd("set number")
	end,

	wrap = function()
		vim.cmd("set wrap!")
	end,
}
return make_logged("adapters/toggler", M)
