local ok, conform = pcall(require, "conform")
if not ok then
	error("Failed to load plugin `stevearc/conform.nvim`")
end

return conform
