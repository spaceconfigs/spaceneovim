local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local searcher_use_case = require("application.use_cases.searcher")

M.oldfiles = function(opts)
	return function()
		searcher_use_case.oldfiles(opts)
	end
end

M.search = function(opts)
	return function()
		searcher_use_case.search(opts)
	end
end

M.search_hover = function(opts)
	return function()
		searcher_use_case.search_hover(opts)
	end
end

M.resume = function(opts)
	return function()
		searcher_use_case.resume(opts)
	end
end

M.search_link_next = function()
	return function()
		searcher_use_case.search_link_next()
	end
end

M.search_link_previous = function()
	return function()
		searcher_use_case.search_link_previous()
	end
end

return make_controller_logged("searcher", M)
