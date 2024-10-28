local M = {}

local logger_use_case = require("application.use_cases.logger")

local quit_commands = {
	[false] = "confirm qall",
	[true] = "wqall",
}

M.quit = function(opts)
	local message = {
		module = "adapters/quit",
		func = "quit",
		opts = opts,
	}
	logger_use_case.debug(message)

	vim.cmd(quit_commands[opts.save or false])
end

return M
