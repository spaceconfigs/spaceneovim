local M = {}

local logger_use_case = require("application.use_cases.logger")
local searcher_use_case = require("application.use_cases.searcher")

M.oldfiles = function(opts)
	return function()
		local message = {
			module = "controllers/searcher",
			func = "oldfiles",
			opts = opts,
		}
		logger_use_case.debug(message)
		searcher_use_case.oldfiles(opts)
	end
end

M.search = function(opts)
	return function()
		local message = {
			module = "controllers/searcher",
			func = "search",
			opts = opts,
		}
		logger_use_case.debug(message)
		searcher_use_case.search(opts)
	end
end

M.search_hover = function(opts)
	return function()
		local message = {
			module = "controllers/searcher",
			func = "search_hover",
			opts = opts,
		}
		logger_use_case.debug(message)
		searcher_use_case.search_hover(opts)
	end
end

M.resume = function(opts)
	return function()
		local message = {
			module = "controllers/searcher",
			func = "resume",
			opts = opts,
		}
		logger_use_case.debug(message)
		searcher_use_case.resume(opts)
	end
end

M.search_link_next = function()
	return function()
		local message = {
			module = "controllers/searcher",
			func = "search_link_next",
		}
		logger_use_case.debug(message)
		searcher_use_case.search_link_next()
	end
end

M.search_link_previous = function()
	return function()
		local message = {
			module = "controllers/searcher",
			func = "search_link_previous",
		}
		logger_use_case.debug(message)
		searcher_use_case.search_link_previous()
	end
end

return M
