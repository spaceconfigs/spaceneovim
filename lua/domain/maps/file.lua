local bookmarker_use_case = require("application.use_cases.bookmarker")
local packager_use_case = require("application.use_cases.packager")
local file_use_case = require("application.use_cases.file")
local tree_use_case = require("application.use_cases.tree")

local bookmark_content = {
	{ key = "b", description = "Bookmark" },
	{ key = "ba", description = "[a]dd Bookmark", method = bookmarker_use_case.add },
	{ key = "bb", description = "List [b]ookmarks", method = bookmarker_use_case.list },
	{ key = "bd", description = "[d]elete Bookmark", method = bookmarker_use_case.remove },
}

local config_content = {
	{ key = "e", description = "Config" },
	{ key = "ed", description = "E[d]it Config", method = file_use_case.edit_config() },
	{ key = "eR", description = "[R]eload Config", method = file_use_case.source_config() },
	{ key = "eU", description = "[U]pdate Packages", method = packager_use_case.update },
}

local yank_content = {
	{ key = "y", description = "Copy" },
	{ key = "yd", description = "[d]irectory", method = file_use_case.copy({ item = "directory" }) },
	{
		key = "yD",
		description = "Project [D]irectory",
		method = file_use_case.copy({ item = "directory", location = "project" }),
	},
	{ key = "yl", description = "[l]ine", method = file_use_case.copy({ extensions = "type_line" }) },
	{
		key = "yL",
		description = "Project [L]ine",
		method = file_use_case.copy({ location = "project", extensions = "type_line" }),
	},
	{ key = "yn", description = "[n]ame", method = file_use_case.copy({ item = "file", location = "file" }) },
	{
		key = "yN",
		description = "[N]ame without extetion",
		method = file_use_case.copy({ item = "file", extensions = "none" }),
	},
	{ key = "yy", description = "Path ([y]ank)", method = file_use_case.copy({ item = "file" }) },
	{ key = "yY", description = "Project path ([Y]ank)", method = file_use_case.copy({ item = "file", location = "project" }) },
}

local file_content = {
	{ key = "D", description = "[D]elete", method = file_use_case.delete_current() },
	{ key = "f", description = "[f]ind", method = file_use_case.list({ location = "file" }) },
	{ key = "r", description = "[r]ecents", method = file_use_case.oldfiles() },
	{ key = "R", description = "[R]ename", method = file_use_case.rename },
	{ key = "s", description = "[s]ave", method = file_use_case.save() },
	{ key = "S", description = "[S]ave All", method = file_use_case.save_all() },
	{ key = "t", description = "[t]ree", method = tree_use_case.toggle({ location = "file" }) },
}

local result = {}
local contents = {}
for _, content in pairs({
	file_content,
	bookmark_content,
	config_content,
	yank_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>f",
	description = "File",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>f" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
