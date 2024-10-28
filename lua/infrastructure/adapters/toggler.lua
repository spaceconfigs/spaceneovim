local M = {}

local make_logged = require("application.helpers.make_logged")

M.number = function()
	vim.cmd("set number")
end

M.wrap = function()
	vim.cmd("set wrap!")
end

return make_logged("adapters/toggler", M)
