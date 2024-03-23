local ok, todo_comments = pcall(require, "todo-comments")

if not ok then
	return vim.notify("Failed to load plugin `todo-comments`")
end
todo_comments.setup()

return todo_comments
