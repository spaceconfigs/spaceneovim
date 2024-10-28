local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.fold")

local cursor_commands = { open = "zc", close = "zo", toggle = "za" }
local all_commands = { toggle = "zA" }

M.fold = function(action, opts)
	local message = {
		module = "adapters/fold",
		func = "fold",
		action = action,
		opts = opts,
	}
	logger_use_case.debug(message)

	if opts.location == "all" then
		if action == "open" then
			plugin.openAllFolds()
		elseif action == "close" then
			plugin.closeAllFolds()
		elseif all_commands[action] then
			vim.cmd("normal! " .. all_commands[action])
		end
		return
	end

	if opts.location == "cursor" then
		vim.cmd("normal! " .. cursor_commands[action])
	end
end

return M
