local make_controller_logged = require("application.helpers.make_controller_logged")
local searcher_use_case = require("application.use_cases.searcher")

---@type SearcherContract
local M = {
	oldfiles = function(opts)
		return function()
			searcher_use_case.oldfiles(opts)
		end
	end,

	search = function(opts)
		return function()
			searcher_use_case.search(opts)
		end
	end,

	search_selection = function(opts)
		return function()
			searcher_use_case.search_selection(opts)
		end
	end,

	search_hover = function(opts)
		return function()
			searcher_use_case.search_hover(opts)
		end
	end,

	resume = function(opts)
		return function()
			searcher_use_case.resume(opts)
		end
	end,

	search_link_next = function()
		return function()
			searcher_use_case.search_link_next()
		end
	end,

	search_link_previous = function()
		return function()
			searcher_use_case.search_link_previous()
		end
	end,
}

return make_controller_logged("searcher", M)
