local use_case = require("application.use_cases.chatbot")

local claudecode_content = {
  { key = "d",  description = "Claude Code" },
  { key = "ds", description = "Start",      method = use_case.session({ action = "start", provider = "claudecode" }) },
  { key = "dc", description = "Continue",   method = use_case.session({ action = "continue", provider = "claudecode" }) },
  { key = "dr", mode = "v",                 description = "Edit region",                                                method = use_case.edit({ provider = "claudecode" }) },
  { key = "dr", description = "Resume",     method = use_case.session({ action = "resume", provider = "claudecode" }) },
  { key = "dl", description = "List",       method = use_case.session({ action = "list", provider = "claudecode" }) },
  { key = "db", description = "Buffer",     method = use_case.session({ action = "buffer", provider = "claudecode" }) },
  { key = "dt", description = "Toggle",     method = use_case.session({ action = "toggle", provider = "claudecode" }) },
  { key = "dq", description = "Stop",       method = use_case.session({ action = "stop", provider = "claudecode" }) },
}

local opencode_content = {
  { key = "o",  description = "Open Code" },
  { key = "os", description = "Start",    method = use_case.session({ action = "start", provider = "opencode" }) },
  { key = "oc", description = "Continue", method = use_case.session({ action = "continue", provider = "opencode" }) },
  { key = "or", mode = "v",               description = "Edit region",                                              method = use_case.edit({ provider = "opencode" }) },
  { key = "or", description = "Resume",   method = use_case.session({ action = "resume", provider = "opencode" }) },
  { key = "ol", description = "List",     method = use_case.session({ action = "list", provider = "opencode" }) },
  { key = "ob", description = "Buffer",   method = use_case.session({ action = "buffer", provider = "opencode" }) },
  { key = "ot", description = "Toggle",   method = use_case.toggle({ action = "toggle", provider = "avante" }) },
  { key = "oq", description = "Stop",     method = use_case.session({ action = "stop", provider = "opencode" }) },
}

local result = {}
local contents = {}
for _, content in pairs({
  claudecode_content,
  opencode_content,
}) do
  for _, bind in pairs(content) do
    table.insert(contents, bind)
  end
end

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
