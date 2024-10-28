local controller = require("application.controllers.chatbot")

local claudecode_content = {
  { key = "d",  description = "Claude Code" },
  { key = "ds", description = "Start",          method = controller.session({ action = "start", provider = "claudecode" }) },
  { key = "dp", description = "Send prompt",    method = controller.send_prompt() },
  { key = "dc", description = "Continue",       method = controller.session({ action = "continue", provider = "claudecode" }) },
  { key = "dr", description = "Resume",         method = controller.session({ action = "resume", provider = "claudecode" }) },
  { key = "dl", description = "List sessions",  method = controller.session({ action = "list", provider = "claudecode" }) },
  { key = "db", description = "Switch buffer",  method = controller.session({ action = "buffer", provider = "claudecode" }) },
  { key = "dt", description = "Toggle window",  method = controller.session({ action = "toggle", provider = "claudecode" }) },
  { key = "dq", description = "Stop",           method = controller.session({ action = "stop", provider = "claudecode" }) },
  { key = "di", mode = "v", description = "Send selection", method = controller.edit({ provider = "claudecode" }) },
  { key = "dm", description = "Select model",   method = controller.select_model() },
  { key = "da", description = "Accept diff",    method = controller.accept_diff() },
  { key = "dx", description = "Deny diff",      method = controller.deny_diff() },
  { key = "df", description = "Add file",       method = controller.add_file() },
}

local result = {}
local contents = claudecode_content

table.insert(result, {
  key = "<leader>$",
  description = "AI",
  mode = "n",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})
for _, content in pairs(contents) do
  local bind = vim.deepcopy(content)
  bind.key = "<leader>$" .. bind.key
  bind.mode = bind.mode or "n"
  bind.buffer = nil
  bind.silent = true
  bind.noremap = true
  bind.nowait = false
  table.insert(result, bind)
end

return result
