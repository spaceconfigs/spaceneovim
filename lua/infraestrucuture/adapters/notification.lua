local vim = vim
local M = {}

local log_levels = require("domain.log_levels")
local plugin = require("infraestrucuture.plugins.notification")
local telescope = require("infraestrucuture.plugins.file")

vim.opt.termguicolors = true

M.notify = function(opts)
	local level = opts.level
	local message = opts.message

	local levels_mapper = {
		[log_levels.DEBUG] = M.debug,
		[log_levels.INFO] = M.info,
		[log_levels.WARN] = M.warn,
		[log_levels.ERROR] = M.error,
	}

	levels_mapper[level]({ message = message })
end

M.dismiss = function()
	plugin.dismiss()
end

M.list = function()
	telescope.extensions.notify.notify({ layout_strategy = "vertical" })
end

M.debug = function(opts)
	plugin.notify(opts.message, log_levels.DEBUG)
end

M.info = function(opts)
	plugin.notify(opts.message, log_levels.INFO)
end

M.warn = function(opts)
	plugin.notify(opts.message, log_levels.WARN)
end

M.error = function(opts)
	plugin.notify(opts.message, log_levels.ERROR)
end

return M
