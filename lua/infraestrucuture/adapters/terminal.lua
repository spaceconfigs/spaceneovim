local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.terminal")
local snacks = plugin.snacks

M.open = function(options)
	local message = {
		module = "adapters/terminal",
		func = "open",
		options = options,
	}
	logger_use_manage.debug(message)

	options = options or {}
	options.type = options.type or "internal"

	if options.type == "external" then
		local terminal_command = vim.fn.getenv("TERMINAL")
		terminal_command = terminal_command or ""

		if terminal_command == "" then
			logger_use_manage.warn({
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
	local message = {
		module = "adapters/terminal",
		func = "close",
		options = options,
	}
	logger_use_manage.debug(message)

	options = options or {}
	options.type = options.type or "internal"

	if options.type == "external" then
		-- External terminals are managed by the system, nothing to close
		return
	end

	-- Close internal terminal
	vim.cmd("ToggleTerm")
	-- snacks.terminal.toggle(nil, { interactive = true, cwd = options.path })
end

M.toggle = function(options)
	local message = {
		module = "adapters/terminal",
		func = "toggle",
		options = options,
	}
	logger_use_manage.debug(message)

	options = options or {}
	options.type = options.type or "internal"

	return M.open(options)
end

return M
