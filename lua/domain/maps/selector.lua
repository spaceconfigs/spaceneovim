local vim = vim
local selector_use_case = require("application.use_cases.selector")

local selector_content = {
	{ key = "r", description = "Multi selection" },
	{ key = "rq", description = "Quit", method = selector_use_case.quit },
	{ key = "rm", description = "All selected", method = selector_use_case.all_selected },
}

local result = {}
local contents = {}
for _, content in pairs({
	selector_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "g" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
