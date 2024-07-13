local ok_workspaces, workspaces = pcall(require, "workspaces")
if not ok_workspaces then
	return vim.notify("Failed to load plugin `natecraddock/workspaces.nvim`")
end

local file = require("application.use_cases.file")

workspaces.setup({
	hooks = {
		open = file.list,
	},
})

return workspaces
