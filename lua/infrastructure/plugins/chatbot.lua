local ok, claudecode = pcall(require, "claudecode")

if not ok then
	error("Failed to load plugin `coder/claudecode.nvim`")
end

return {
	claudecode = claudecode,
}
