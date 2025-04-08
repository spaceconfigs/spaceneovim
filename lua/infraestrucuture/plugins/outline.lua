local outline_ok, outline = pcall(require, "outline")

if not outline_ok then
	error("Failed to load plugin `hedyhli/outline.nvim`")
end

return {
	outline = outline,
}
