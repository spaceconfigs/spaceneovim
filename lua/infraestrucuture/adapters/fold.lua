local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.fold")

M.open = function(opts)
	local message = {
		module = "adapters/fold",
		func = "open",
		opts = opts,
	}
	logger_use_manage.debug(message)

	if opts.location == "all" then
		plugin.openAllFolds()
	end

	if opts.location == "cursor" then
		vim.cmd("normal! zc")
	end
end

M.close = function(opts)
	local message = {
		module = "adapters/fold",
		func = "close",
		opts = opts,
	}
	logger_use_manage.debug(message)

	if opts.location == "all" then
		plugin.closeAllFolds()
	end

	if opts.location == "cursor" then
		vim.cmd("normal! zo")
	end
end

M.toggle = function(opts)
	local message = {
		module = "adapters/fold",
		func = "toggle",
		opts = opts,
	}
	logger_use_manage.debug(message)

	if opts.location == "all" then
		vim.cmd("normal! zA")
	end

	if opts.location == "cursor" then
		vim.cmd("normal! za")
	end
end
return M
