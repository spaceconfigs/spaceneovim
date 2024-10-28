local ok, claudecode = pcall(require, "claudecode")

if not ok then
	error("Failed to load plugin `coder/claudecode.nvim`")
end

claudecode.terminal = require("claudecode.terminal")

return {
	claudecode = claudecode,
}
