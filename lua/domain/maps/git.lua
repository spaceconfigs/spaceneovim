local versior_use_case = require("application.use_cases.versior")

local git_content = {
	{ key = "s", description = "Neogit Status", method = versior_use_case.open, },
	{ key = "S", description = "Neogit Status", method = versior_use_case.stage_file, },
	{ key = "U", description = "Neogit Status", method = versior_use_case.unstage_file, },
	{ key = "b", description = "Blame Line", method = versior_use_case.blame_line, },
}


local result = {}
local contents = {}
for _, content in pairs({
	git_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>g",
	description = "Git",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>g" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = true
	table.insert(result, bind)
end

return result
