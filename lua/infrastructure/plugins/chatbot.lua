local ok_avante, avante = pcall(require, "avante")
local ok_opencode, opencode = pcall(require, "opencode")
local ok_claudecode, claudecode = pcall(require, "claudecode")
local ok_ncphub, mcphub = pcall(require, "mcphub")

if not ok_avante then
	error("Failed to load plugin `yetone/avante.nvim`")
end

if not ok_opencode then
	error("Failed to load plugin `NickvanDyke/opencode.nvim`")
end

if not ok_claudecode then
	error("Failed to load plugin `coder/claudecode.nvim`")
end

if not ok_ncphub then
	error("Failed to load plugin `ravitemer/mcphub.nvim`")
end

vim.opt.laststatus = 3

return {
	avante = avante,
	opencode = opencode,
	claudecode = claudecode,
	mcphub = mcphub,
}
