local M = {}

local ok, hop = pcall(require, "hop")
if not ok then
	return vim.notify("Failed to load plugin `phaazon/hop.nvim`")
end
hop.setup()

return hop
