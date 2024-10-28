local ok_claudecode, claudecode = pcall(require, "claudecode")

if not ok_claudecode then
	error("Failed to load plugin `coder/claudecode.nvim`")
end

vim.opt.laststatus = 3

return {
	claudecode = claudecode,
}
