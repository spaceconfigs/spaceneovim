local ok, bookmarks = pcall(require, "bookmarks")
if not ok then
	return vim.notify("Failed to load plugin `tomasky/bookmarks.nvim`")
end

local ok_telescope, telescope = pcall(require, "telescope")
if not ok_telescope then
	return vim.notify("Failed to load plugin `nvim-telescope/telescope.nvim`")
end

require("telescope").load_extension("bookmarks")

bookmarks.setup({
	save_file = vim.fn.stdpath("state") .. "/bookmarks",
})

require("telescope").load_extension("bookmarks")

bookmarks.bookmarks_list_telescope = function()
	require("telescope").extensions.bookmarks.list()
end

return {
	bookmarks = bookmarks,
}
