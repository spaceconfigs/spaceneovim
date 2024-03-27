local linenumber_use_case = require("application.use_cases.linenumber")

local numberline_content = {
	{ key = "n", description = "Line-number" },
	{ key = "na", description = "Absolute line number", method = linenumber_use_case.toggle_absolute },
	{ key = "nr", description = "Relative line number", method = linenumber_use_case.toggle_relative },
	{ key = "nv", description = "Visual line number", method = ":set number<cr>" },
}

local toggler_content = {
	{ key = "l", description = "Truncate line", method = ":set wrap!<cr>" },
}

local result = {}
local contents = {}
for _, content in pairs({
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
