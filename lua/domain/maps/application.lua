local todo_controller = require("application.controllers.todo")
local changer_controller = require("application.controllers.changer")
local documentation_controller = require("application.controllers.documentation")

local reader_content = {
  { key = "r",   description = "Reader" },
  { key = "rzd", description = "Devdocs list", method = documentation_controller.open() },
  { key = "rzD", description = "Devdocs list", method = documentation_controller.install() },
}


local org_content = {
  { key = "o",  description = "Org" },
  { key = "ot", description = "TODO list", method = todo_controller.list() },
}

local changer = {
  { key = "u", description = "Undo tree", method = changer_controller.list() },
}

local result = {}
local contents = {}
for _, content in pairs({
  org_content,
  changer,
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
  local bind = vim.deepcopy(content)
  bind.key = "<leader>a" .. bind.key
  bind.mode = "n"
  bind.buffer = nil
  bind.silent = true
  bind.noremap = true
  bind.nowait = false
  table.insert(result, bind)
end

return result
