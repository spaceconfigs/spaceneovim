local todo_controller = require("application.controllers.todo")
local changer_controller = require("application.controllers.changer")
local documentation_controller = require("application.controllers.documentation")
local chatbot_controller = require("application.controllers.chatbot")

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

local claudecode_content = {
  { key = "c",  description = "Claude Code" },
  { key = "cc", description = "Toggle",        method = chatbot_controller.toggle({ provider = "claudecode" }) },
  { key = "cs", description = "Start",         method = chatbot_controller.session({ action = "start", provider = "claudecode" }) },
  { key = "cp", mode = "v",                    description = "Send prompt",    method = chatbot_controller.send_prompt({ provider = "claudecode" }) },
  { key = "cn", description = "Continue",      method = chatbot_controller.session({ action = "continue", provider = "claudecode" }) },
  { key = "cr", description = "Resume",        method = chatbot_controller.session({ action = "resume", provider = "claudecode" }) },
  { key = "cl", description = "List sessions", method = chatbot_controller.session({ action = "list", provider = "claudecode" }) },
  { key = "cb", description = "Switch buffer", method = chatbot_controller.session({ action = "buffer", provider = "claudecode" }) },
  { key = "ct", description = "Toggle window", method = chatbot_controller.session({ action = "toggle", provider = "claudecode" }) },
  { key = "cq", description = "Stop",          method = chatbot_controller.session({ action = "stop", provider = "claudecode" }) },
  { key = "ci", mode = "v",                    description = "Send selection", method = chatbot_controller.edit({ provider = "claudecode" }) },
  { key = "cm", description = "Select model",  method = chatbot_controller.select_model({ provider = "claudecode" }) },
  { key = "ca", description = "Accept diff",   method = chatbot_controller.accept_diff({ provider = "claudecode" }) },
  { key = "cx", description = "Deny diff",     method = chatbot_controller.deny_diff({ provider = "claudecode" }) },
  { key = "cf", description = "Add file",      method = chatbot_controller.add_file({ provider = "claudecode" }) },
}

local result = {}
local contents = {}
for _, content in pairs({
  org_content,
  changer,
  reader_content,
  claudecode_content,
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
