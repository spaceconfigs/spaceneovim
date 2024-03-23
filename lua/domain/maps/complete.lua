local use_case = require("application.use_cases.completer")

local maps = {
	{ key = "<C-Space>", description = "Complete", method = use_case.complete },
}

local result = {}
local contents = {}
for _, content in pairs({
	maps,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.mode = "i"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = true
	table.insert(result, bind)
end

return result
