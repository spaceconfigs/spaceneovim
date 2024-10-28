local ok, claudecode = pcall(require, "claudecode")

if not ok then
	error("Failed to load plugin `coder/claudecode.nvim`")
end

claudecode.terminal = require("claudecode.terminal")

local ok_hub, mcphub_state = pcall(require, "mcphub.state")

if not ok_hub then
	error("Failed to load plugin `ravitemer/mcphub.nvim`")
end

return {
	claudecode = claudecode,
	mcphub_state = mcphub_state,
}
