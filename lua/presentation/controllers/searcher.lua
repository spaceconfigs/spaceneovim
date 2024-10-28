local make_controller_logged = require("application.helpers.make_controller_logged")
local searcher_usecase = require("application.ports.use_case_registry").searcher()

---@type SearcherContract
local M = {
	oldfiles = function(opts)
		return function()
			searcher_usecase.oldfiles(opts)
		end
	end,

	search = function(opts)
		return function()
			searcher_usecase.search(opts)
		end
	end,

	search_selection = function(opts)
		return function()
			searcher_usecase.search_selection(opts)
		end
	end,

	search_hover = function(opts)
		return function()
			searcher_usecase.search_hover(opts)
		end
	end,

	resume = function(opts)
		return function()
			searcher_usecase.resume(opts)
		end
	end,

	search_link_next = function()
		return function()
			searcher_usecase.search_link_next()
		end
	end,

	search_link_previous = function()
		return function()
			searcher_usecase.search_link_previous()
		end
	end,
}

return make_controller_logged("searcher", M)
