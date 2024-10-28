local controller = require("application.controllers.chatbot")

local content = {
  { key = "$", description = "Toggle",        method = controller.toggle() },
  { key = "s", description = "Start",         method = controller.session({ action = "start" }) },
  { key = "p", mode = "v",                    description = "Send prompt",    method = controller.send_prompt() },
  { key = "c", description = "Continue",      method = controller.session({ action = "continue" }) },
  { key = "r", description = "Resume",        method = controller.session({ action = "resume" }) },
  { key = "l", description = "List sessions", method = controller.session({ action = "list" }) },
  { key = "b", description = "Switch buffer", method = controller.session({ action = "buffer" }) },
  { key = "t", description = "Toggle window", method = controller.session({ action = "toggle" }) },
  { key = "q", description = "Stop",          method = controller.session({ action = "stop" }) },
  { key = "i", mode = "v",                    description = "Send selection", method = controller.edit() },
  { key = "m", description = "Select model",  method = controller.select_model() },
  { key = "a", description = "Accept diff",   method = controller.accept_diff() },
  { key = "x", description = "Deny diff",     method = controller.deny_diff() },
  { key = "f", description = "Add file",      method = controller.add_file() },
}

local result = {}

table.insert(result, {
  key = "<leader>$",
  description = "AI",
  mode = "n",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})

for _, entry in pairs(content) do
  local bind = vim.deepcopy(entry)
  bind.key = "<leader>$" .. bind.key
  bind.mode = bind.mode or "n"
  bind.buffer = nil
  bind.silent = true
  bind.noremap = true
  bind.nowait = false
  table.insert(result, bind)
end

return result
