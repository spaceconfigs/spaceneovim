local clone = require("domain.utils.table").clone
local application_map = require("domain.maps.application")
local buffer_map = require("domain.maps.buffer")
local chatbot_map = require("domain.maps.chatbot")
local help_map = require("domain.maps.help")
local debugger_map = require("domain.maps.debugger")
local error_map = require("domain.maps.error")
local file_map = require("domain.maps.file")
local git_map = require("domain.maps.git")
local jump_map = require("domain.maps.jump")
local layout_map = require("domain.maps.layout")
local major_map = require("domain.maps.major")
local project_map = require("domain.maps.project")
local search_map = require("domain.maps.search")
local toggler_map = require("domain.maps.toggler")
local quit_map = require("domain.maps.quit")
local window_map = require("domain.maps.window")
local unprefixed_map = require("domain.maps.unprefixed")
local selector_map = require("domain.maps.selector")
local ui_map = require("domain.maps.ui")
local yank_map = require("domain.maps.yank")
local zoom_map = require("domain.maps.zoom")

---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
	---@type KeyBind[]
	local default_map = {
		{ key = "<leader>", description = "Commands", method = controllers.commander.find() },
		{ key = "1", description = "Window 1", method = controllers.window.go_to({ number = 1 }) },
		{ key = "2", description = "Window 2", method = controllers.window.go_to({ number = 2 }) },
		{ key = "3", description = "Window 3", method = controllers.window.go_to({ number = 3 }) },
		{ key = "4", description = "Window 4", method = controllers.window.go_to({ number = 4 }) },
		{ key = "5", description = "Window 5", method = controllers.window.go_to({ number = 5 }) },
		{ key = "6", description = "Window 6", method = controllers.window.go_to({ number = 6 }) },
		{ key = "7", description = "Window 7", method = controllers.window.go_to({ number = 7 }) },
		{ key = "8", description = "Window 8", method = controllers.window.go_to({ number = 8 }) },
		{ key = "9", description = "Window 9", method = controllers.window.go_to({ number = 9 }) },
		{ key = ";", description = "Comment line", method = controllers.commenter.toggle_current_line() },
		{
			key = ";",
			description = "Comment line",
			method = controllers.commenter.toggle_current_line_visual_mode(),
			mode = "v",
		},
		{ key = "<Tab>", description = "Previous buffer", method = controllers.buffer.reopen() },
		{
			key = "'",
			mode = { "n" },
			description = "Terminal",
			method = controllers.terminal.toggle(),
		},
		{
			key = '"',
			mode = { "n", "t" },
			description = "External terminal",
			method = controllers.terminal.toggle({ type = "external" }),
		},
	}

	local results = {}
	for _, content in pairs({
		default_map,
	}) do
		for _, bind in pairs(content) do
			local result = clone(bind)
			result.key = "<leader>" .. result.key
			result.mode = result.mode or "n"
			result.buffer = nil
			result.silent = true
			result.noremap = true
			result.nowait = false
			table.insert(results, result)
		end
	end

	for _, map in ipairs({
		application_map,
		chatbot_map,
		major_map,
		file_map,
		buffer_map,
		debugger_map,
		error_map,
		git_map,
		jump_map,
		layout_map,
		project_map,
		search_map,
		quit_map,
		window_map,
		help_map,
		toggler_map,
		unprefixed_map,
		selector_map,
		ui_map,
		yank_map,
		zoom_map,
	}) do
		for _, bind in pairs(map(controllers)) do
			table.insert(results, bind)
		end
	end

	return results
end
