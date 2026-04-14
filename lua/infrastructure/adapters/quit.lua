local M = {}

local make_logged = require("application.helpers.make_logged")

local quit_commands = {
	[false] = "confirm qall",
	[true] = "wqall",
}

M.quit = function(opts)
	vim.cmd(quit_commands[opts.save or false])
end

M.restart = function()
	vim.cmd("restart")
end

return make_logged("adapters/quit", M)
