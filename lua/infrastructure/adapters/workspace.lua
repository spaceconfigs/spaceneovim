local make_logged = require("application.helpers.make_logged")
local file_usecase = require("application.usecases.file")
local plugin = require("infrastructure.plugins.plugin_registry").workspaces()
local workspaces = plugin.workspaces
local snacks = plugin.snacks

---@type WorkspacePort
local M = {
  open = function()
    snacks.picker.projects({
      confirm = function(picker, item)
        picker:close()
        vim.fn.chdir(item.file)

        file_usecase.list({ location = "project" })
      end,
    })
  end,

  add = function(opts)
    workspaces.add(opts.path)
  end,
}

return make_logged("adapters/workspace", M)
