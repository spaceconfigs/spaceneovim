local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  error("Failed to load plugin `folke/snacks.nvim`")
end

local todo_comments_ok, todo_comments = pcall(require, "todo-comments")
if not todo_comments_ok then
  error("Failed to load plugin `folke/todo-comments.nvim`")
end

return {
  snacks = snacks,
  todo_comments = todo_comments,
}
