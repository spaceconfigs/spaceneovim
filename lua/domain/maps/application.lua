---@type TodoContract
local todo_controller = require("application.controllers.todo")
---@type ChangerContract
local changer_controller = require("application.controllers.changer")
---@type DocumentationContract
local documentation_controller = require("application.controllers.documentation")
---@type ChatbotContract
local chatbot_controller = require("application.controllers.chatbot")

---@type KeyBind[]
local reader_content = {
  { key = "r",   description = "Reader" },
  { key = "rzd", description = "Devdocs list", method = documentation_controller.open() },
  { key = "rzD", description = "Devdocs list", method = documentation_controller.install() },
}


---@type KeyBind[]
local org_content = {
  { key = "o",  description = "Org" },
  { key = "ot", description = "TODO list", method = todo_controller.list() },
}

---@type KeyBind[]
local changer = {
  { key = "u", description = "Undo tree", method = changer_controller.list() },
}

---@type KeyBind[]
local chatbot_content = {
  { key = "c",    description = "AI" },
  { key = "cc",   description = "Toggle",                method = chatbot_controller.toggle() },
  { key = "cs",   mode = "v",                            description = "Send selection",     method = chatbot_controller.send() },
  { key = "cb",   description = "Send buffer",            method = chatbot_controller.add_buffer() },
  { key = "ca",   description = "Add text to context",    method = chatbot_controller.add() },
  { key = "cf",   description = "Add file to context",    method = chatbot_controller.add_file() },
  { key = "cl",   description = "Select model",           method = chatbot_controller.select_model() },
  { key = "cF",   description = "Focus chat window",      method = chatbot_controller.focus() },
  { key = "$a",   description = "Accept diff",            method = chatbot_controller.diff_accept() },
  { key = "$d",   description = "Deny diff",              method = chatbot_controller.diff_deny() },
  { key = "cr",   description = "Resume session",         method = chatbot_controller.resume() },
  { key = "cC",   description = "Continue session",       method = chatbot_controller.continue() },
  { key = "cS",   description = "Status",                 method = chatbot_controller.status() },
}

local result = {}
local contents = {}
for _, content in pairs({
  org_content,
  changer,
  reader_content,
  chatbot_content,
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
