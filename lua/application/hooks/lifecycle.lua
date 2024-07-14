local M = {}

local maps = require("domain.maps")
local theme_use_case = require("application.use_cases.theme")
local completer_use_case = require("application.use_cases.completer")
local keymaper_usecase = require("application.use_cases.keymapper")
local logger_use_manage = require("application.use_cases.logger")

M.onModuleInit = function()
	local message = {
		module = "events/lifecycle",
		func = "onModuleInit",
	}
	logger_use_manage.debug(message)
	completer_use_case.setup()

	keymaper_usecase.register_all(maps)
	theme_use_case.load()
end

return M
