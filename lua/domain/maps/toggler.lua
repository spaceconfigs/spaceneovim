local linenumber_controller = require("application.controllers.linenumber")
local statusline_controller = require("application.controllers.statusline")
local toggler_controller = require("application.controllers.toggler")

local statusline_content = {
	{ key = "m", description = "Statusline" },
	{ key = "mT", description = "Toggle", method = statusline_controller.toggle() },
}

local numberline_content = {
	{ key = "n", description = "Line-number" },
	{ key = "na", description = "Absolute line number", method = linenumber_controller.toggle_absolute() },
	{ key = "nr", description = "Relative line number", method = linenumber_controller.toggle_relative() },
	{ key = "nv", description = "Visual line number", method = toggler_controller.number() },
}

local toggler_content = {
	{ key = "l", description = "Truncate line", method = toggler_controller.wrap() },
}

local result = {}
local contents = {}
for _, content in pairs({
	statusline_content,
	numberline_content,
	toggler_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>t",
	description = "Toggle",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>t" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
