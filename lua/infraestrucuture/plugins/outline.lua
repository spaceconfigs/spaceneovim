local ok, outline = pcall(require, "outline")
if not ok then
	return vim.notify("Failed to load plugin `hedyhli/outline.nvim`")
end

outline.setup()

return outline
