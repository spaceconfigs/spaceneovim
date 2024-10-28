local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
  local adapter = require("application.ports.adapter_registry").workspace()
  local file_util = require("application.ports.adapter_registry").file_util()
  local lsp_usecase = require("application.ports.usecase_registry").lsp()
  local file_usecase = require("application.ports.usecase_registry").file()

  return adapter, lsp_usecase, file_util, file_usecase
end

M.add = function()
  local adapter = M.setup()
  local editor = require("application.ports.adapter_registry").editor()
  local path = editor.cwd()

  adapter.add({ path = path })
end

M.open = function()
  local adapter = M.setup()

  adapter.open()
end

M.files = function()
  local _, _, _, file_usecase = M.setup()

  file_usecase.list({ location = "profile" })
end

M.grep_input = function()
  local searcher_usecase = require("application.ports.usecase_registry").searcher()

  searcher_usecase.search_input({ location = "project" })
end

M.diagnostics = function()
  local _, lsp_usecase = M.setup()

  lsp_usecase.diagnostics()
end

M.add_and_toggle_tree = function()
  local tree_usecase = require("application.usecases.tree")
  M.add()
  tree_usecase.toggle()
end

return make_logged("usecases/workspace", M)
