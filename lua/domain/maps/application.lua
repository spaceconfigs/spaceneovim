local clone = require("domain.utils.table").clone
---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
  ---@type KeyBind[]
  local reader_content = {
    { key = "r",   description = "Reader" },
    { key = "rzd", description = "Devdocs list", method = controllers.documentation.open() },
    { key = "rzD", description = "Devdocs list", method = controllers.documentation.install() },
  }


  ---@type KeyBind[]
  local org_content = {
    { key = "o",  description = "Org" },
    { key = "ot", description = "TODO list", method = controllers.todo.list() },
  }

  ---@type KeyBind[]
  local changer = {
    { key = "u", description = "Undo tree", method = controllers.changer.list() },
  }

  ---@type KeyBind[]
  local chatbot_content = {
    { key = "c",    description = "AI" },
    { key = "cc",   description = "Toggle",                method = controllers.chatbot.toggle() },
    { key = "cs",   mode = "v",                            description = "Send selection",     method = controllers.chatbot.send() },
    { key = "cb",   description = "Send buffer",            method = controllers.chatbot.add_buffer() },
    { key = "ca",   description = "Add text to context",    method = controllers.chatbot.add() },
    { key = "cf",   description = "Add file to context",    method = controllers.chatbot.add_file() },
    { key = "cl",   description = "Select model",           method = controllers.chatbot.select_model() },
    { key = "cF",   description = "Focus chat window",      method = controllers.chatbot.focus() },
    { key = "$a",   description = "Accept diff",            method = controllers.chatbot.diff_accept() },
    { key = "$d",   description = "Deny diff",              method = controllers.chatbot.diff_deny() },
    { key = "cr",   description = "Resume session",         method = controllers.chatbot.resume() },
    { key = "cC",   description = "Continue session",       method = controllers.chatbot.continue() },
    { key = "cS",   description = "Status",                 method = controllers.chatbot.status() },
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
