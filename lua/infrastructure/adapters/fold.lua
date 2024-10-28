local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.fold")

local cursor_commands = { open = "zc", close = "zo", toggle = "za" }
local all_commands = { toggle = "zA" }

---@type FoldAdapter
local M = {
	fold = function(action, opts)
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
	end,
}

return make_logged("adapters/fold", M)
