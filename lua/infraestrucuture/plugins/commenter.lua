local ok_comment, comment = pcall(require, "Comment")
if not ok_comment then
	return vim.notify("Failed to load plugin `numToStr/Comment.nvim`")
end

local config = {}

local ok_ts_context_commentstring, ts_context_commentstring = pcall(require, "ts_context_commentstring")
if not ok_ts_context_commentstring then
	vim.notify("Failed to load plugin `JoosepAlviste/nvim-ts-context-commentstring`")

	ts_context_commentstring.setup()
	config.pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
end

comment.setup(config)

local result = {}
for key, value in pairs(comment) do
	result[key] = value
end

result.api = require("Comment.api")

return result
