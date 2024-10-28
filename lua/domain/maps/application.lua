local clone_util = require("domain.utils.table").clone
local changer_controller = require("domain.contracts.controller_registry").changer()
local documentation_controller = require("domain.contracts.controller_registry").documentation()
local todo_controller = require("domain.contracts.controller_registry").todo()
---@return KeyBind[]
return function()
  ---@type KeyBind[]
  local reader_content = {
    { key = "r",   description = "Reader" },
    { key = "rzd", description = "Devdocs list", method = documentation_controller.open() },
    { key = "rzD", description = "Devdocs remove",  method = documentation_controller.remove() },
    { key = "rzI", description = "Devdocs install", method = documentation_controller.install() },
  }


  ---@type KeyBind[]
  local org_content = {
    { key = "o",  description = "Org" },
    { key = "ot", description = "TODO list", method = todo_controller.list() },
  }

  ---@type KeyBind[]
  local changer_content = {
    { key = "u", description = "Undo tree", method = changer_controller.list() },
  }

  local result = {}
  local contents = {}
  for _, content in pairs({
    org_content,
    changer_content,
    reader_content,
  }) do
    for _, bind in pairs(content) do
      table.insert(contents, bind)
    end
  end

  table.insert(result, {
    key = "<leader>a",
    description = "Application",
    mode = "n",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })
  for _, content in pairs(contents) do
    local bind = clone_util(content)
    bind.key = "<leader>a" .. bind.key
    bind.mode = "n"
    bind.buffer = nil
    bind.silent = true
    bind.noremap = true
    bind.nowait = false
    table.insert(result, bind)
  end

  return result
end
