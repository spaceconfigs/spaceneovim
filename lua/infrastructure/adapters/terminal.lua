local vim = vim
local M = {}

local make_logged = require("application.helpers.make_logged")
local logger_use_case = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.terminal")
local snacks = plugin.snacks

M.open = function(options)
	if options.type == "external" then
		local terminal_command = vim.fn.getenv("TERMINAL")
		terminal_command = terminal_command or ""

		if terminal_command == "" then
			logger_use_case.warn({
				module = "adapters/terminal",
				message = "TERMINAL environment variable not set",
			})
			return
		end

		return vim.fn.system(terminal_command)
	end

	-- Internal terminal
	if options.path then
		return vim.cmd("ToggleTerm dir=" .. options.path)
	end

	vim.cmd("ToggleTerm")
	-- snacks.terminal.toggle(nil, { interactive = true, cwd = options.path })
end

M.close = function(options)
	if options.type == "external" then
		-- External terminals are managed by the system, nothing to close
		return
	end

	-- Close internal terminal
	vim.cmd("ToggleTerm")
	-- snacks.terminal.toggle(nil, { interactive = true, cwd = options.path })
end

M.toggle = function(options)
	return M.open(options)
end

return make_logged("adapters/terminal", M)
