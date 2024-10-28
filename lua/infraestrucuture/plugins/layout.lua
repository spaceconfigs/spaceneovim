local ok, session_manager = pcall(require, "session_manager")
if not ok then
	return vim.notify("Failed to load plugin `Shatur/neovim-session-manager`")
end

local config = require("session_manager.config")
session_manager.setup({
	autoload_mode = config.AutoloadMode.Disabled,
	autosave_last_session = false,
	autosave_only_in_session = false,
})

return session_manager
