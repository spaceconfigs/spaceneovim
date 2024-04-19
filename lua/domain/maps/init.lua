local application_map = require("domain.maps.application")
local buffer_map = require("domain.maps.buffer")
local chatbot_map = require("domain.maps.chatbot")
local complete_map = require("domain.maps.complete")
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
local terminal_use_case = require("application.use_cases.terminal")
local commenter_use_case = require("application.use_cases.commenter")
local buffer_use_case = require("application.use_cases.buffer")

local default_map = {
	{ key = ";", description = "Comment line", method = commenter_use_case.toggle_current_line },
	{
		key = ";",
		description = "Comment line",
		mode = "v",
		method = commenter_use_case.toggle_current_line_visual_mode,
	},
	{ key = "<Tab>", description = "Previous buffer", method = buffer_use_case.reopen },
	{ key = "'", description = "Terminal", method = terminal_use_case.toggle_buffer_dir },
}

local results = {}
for _, content in pairs({
	default_map,
}) do
	for _, bind in pairs(content) do
		local result = vim.deepcopy(bind)
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
	complete_map,
	help_map,
	toggler_map,
	unprefixed_map,
}) do
	for _, content in pairs(map) do
		table.insert(results, content)
	end
end

return results
