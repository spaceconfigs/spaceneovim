local bookmarker_use_case = require("application.use_cases.bookmarker")
local packager_use_case = require("application.use_cases.packager")
local file_use_case = require("application.use_cases.file")
local tree_use_case = require("application.use_cases.tree")

local bookmark_content = {
	{ key = "b", description = "Bookmark" },
	{ key = "ba", description = "Add Bookmark", method = bookmarker_use_case.add },
	{ key = "bb", description = "List Bookmarks", method = bookmarker_use_case.list },
	{ key = "bd", description = "Delete Bookmark", method = bookmarker_use_case.remove },
}

local config_content = {
	{ key = "e", description = "Config" },
	{ key = "ed", description = "Edit Config", method = "<cmd>edit $MYVIMRC<cr>" },
	{ key = "eR", description = "Reload Config", method = "<cmd>source $MYVIMRC<cr>" },
	{ key = "eU", description = "Update Packages", method = packager_use_case.update },
}

local file_content = {
	{ key = "D", description = "Delete", method = "<cmd>call delete(expand('%')) | bdelete!<cr>" },
	{ key = "f", description = "Find", method = file_use_case.list },
	{ key = "r", description = "Recents", method = file_use_case.oldfiles },
	{ key = "R", description = "Rename", method = file_use_case.rename },
	{ key = "s", description = "Save", method = "<cmd>write!<cr>" },
	{ key = "S", description = "Save All", method = "<cmd>wall!<cr>" },
	{ key = "t", description = "Tree", method = tree_use_case.toggle },
}

local result = {}
local contents = {}
for _, content in pairs({
	file_content,
	bookmark_content,
	config_content,
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
	nowait = true,
})

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>f" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = true
	table.insert(result, bind)
end

return result
