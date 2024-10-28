local ok, obsidian = pcall(require, "obsidian")
if not ok then
	error("Failed to load plugin `epwalsh/obsidian.nvim`")
end

return obsidian
