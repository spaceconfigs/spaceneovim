local fold_use_case = require("application.use_cases.fold")

local toggler_content = {
	{ key = ".", description = "Fold" },
	{ key = ".a", description = "Toggle", method = fold_use_case.toggle({ location = "cursor" }) },
	{ key = ".c", description = "Close", method = fold_use_case.close({ location = "cursor" }) },
	{ key = ".o", description = "Open", method = fold_use_case.open({ location = "cursor" }) },
	{ key = ".m", description = "Close All", method = fold_use_case.close({ location = "all" }) },
	{ key = ".r", description = "Open All", method = fold_use_case.open({ location = "all" }) },
}

local result = {}
local contents = {}

for _, content in pairs({
	toggler_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>z",
	description = "Zoom",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>z" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
