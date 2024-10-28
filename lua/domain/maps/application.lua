local clone = require("domain.utils.table").clone
local changer = require("domain.contracts.registry").changer()
local chatbot = require("domain.contracts.registry").chatbot()
local documentation = require("domain.contracts.registry").documentation()
local todo = require("domain.contracts.registry").todo()
---@return KeyBind[]
return function()
  ---@type KeyBind[]
  local reader_content = {
    { key = "r",   description = "Reader" },
    { key = "rzd", description = "Devdocs list", method = documentation.open() },
    { key = "rzD", description = "Devdocs list", method = documentation.install() },
  }


  ---@type KeyBind[]
  local org_content = {
    { key = "o",  description = "Org" },
    { key = "ot", description = "TODO list", method = todo.list() },
  }

  ---@type KeyBind[]
  local changer = {
    { key = "u", description = "Undo tree", method = changer.list() },
  }

  ---@type KeyBind[]
  local chatbot_content = {
    { key = "c",    description = "AI" },
    { key = "cc",   description = "Toggle",                method = chatbot.toggle() },
    { key = "cs",   mode = "v",                            description = "Send selection",     method = chatbot.send() },
    { key = "cb",   description = "Send buffer",            method = chatbot.add_buffer() },
    { key = "ca",   description = "Add text to context",    method = chatbot.add() },
    { key = "cf",   description = "Add file to context",    method = chatbot.add_file() },
    { key = "cl",   description = "Select model",           method = chatbot.select_model() },
    { key = "cF",   description = "Focus chat window",      method = chatbot.focus() },
    { key = "$a",   description = "Accept diff",            method = chatbot.diff_accept() },
    { key = "$d",   description = "Deny diff",              method = chatbot.diff_deny() },
    { key = "cr",   description = "Resume session",         method = chatbot.resume() },
    { key = "cC",   description = "Continue session",       method = chatbot.continue() },
    { key = "cS",   description = "Status",                 method = chatbot.status() },
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
    local bind = clone(content)
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
