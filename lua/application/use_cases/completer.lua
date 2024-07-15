local M = {}

local logger_use_case = require("application.use_cases.logger")
local adapter = require("infraestrucuture.adapters.completer")

M.setup = function()
	adapter.setup()
end

M.complete = function()
	local message = {
		module = "use_cases/commenter",
		func = "complete",
	}
	logger_use_case.debug(message)

	adapter.complete()
end

return M
