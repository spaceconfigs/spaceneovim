local file_usecase = require("application.use_cases.file")

local ok_telescope, telescope = pcall(require, "telescope")
if not ok_telescope then
  return vim.notify("Failed to load plugin `nvim-telescope/telescope.nvim`")
end

local ok_workspaces, workspaces = pcall(require, "workspaces")
if not ok_workspaces then
  return vim.notify("Failed to load plugin `natecraddock/workspaces.nvim`")
end

workspaces.setup({
  hooks = {
    open = file_usecase.list({ location = "profile" }),
  },
})

workspaces.workspaces = function()
  telescope.extensions.workspaces.workspaces()
end

return workspaces
