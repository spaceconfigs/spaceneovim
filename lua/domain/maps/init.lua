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
	{ key = ";", description = "Toggle comment line", method = commenter_use_case.toggle_current_line },
	{ key = "<Tab>", description = "Previous buffer", method = buffer_use_case.reopen },
	{ key = "'", description = "Terminal", method = terminal_use_case.toggle_buffer_dir },
}

local result = {}
local contents = {}
for _, content in pairs({
	default_map,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = true
	table.insert(result, bind)
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
	project_map,
	search_map,
	quit_map,
	window_map,
	complete_map,
	help_map,
	toggler_map,
	unprefixed_map,
}) do
	table.insert(result, map)
end

return result
