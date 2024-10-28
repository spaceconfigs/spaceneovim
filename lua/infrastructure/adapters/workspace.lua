local make_logged = require("application.helpers.make_logged")
local file_use_case = require("application.use_cases.file")
local plugin = require("infrastructure.plugins.workspaces")
local workspaces = plugin.workspaces
local snacks = plugin.snacks

---@type WorkspaceAdapter
local M = {
  open = function()
    snacks.picker.projects({
      confirm = function(picker, item)
        picker:close()
        vim.fn.chdir(item.file)

        file_use_case.list({ location = "project" })
      end,
    })
  end,

  add = function(opts)
    workspaces.add(opts.path)
  end,
}

return make_logged("adapters/workspace", M)
