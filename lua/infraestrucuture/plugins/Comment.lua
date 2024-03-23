local ok, plugin = pcall(require, "Comment")
if not ok then
	return vim.notify("Failed to load plugin `numToStr/Comment.nvim`")
end

plugin.setup()

local result = {}
for key, value in pairs(plugin) do
	result[key] = value
end

result.api = require("Comment.api")

return result
