local todo_use_case = require("application.use_cases.todo")
local changer_use_case = require("application.use_cases.changer")
local documentation_use_case = require("application.use_cases.documentation")

local reader_content = {
  { key = "r",   description = "Reader" },
  { key = "rzd", description = "Devdocs list", method = documentation_use_case.open },
  { key = "rzD", description = "Devdocs list", method = documentation_use_case.install },
}


local org_content = {
  { key = "o",  description = "Org" },
  { key = "ot", description = "TODO list", method = todo_use_case.list },
}

local changer = {
  { key = "u", description = "Undo tree", method = changer_use_case.list },
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
