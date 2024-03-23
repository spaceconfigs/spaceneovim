local M = {}

local logger_use_manage = require("application.use_cases.logger")
local hop = require("infraestrucuture.plugins.hop")

-- print(vim.inspect(hop))

M.words = function()
	local message = {
		module = "adapters/jumper",
		func = "words",
	}
	logger_use_manage.debug(message)

	hop.hint_char1 ({ multi_windows = true })
end

M.lines = function()
	local message = {
		module = "adapters/jumper",
		func = "lines",
	}
	logger_use_manage.debug(message)

	hop.hint_lines()
end

return M
