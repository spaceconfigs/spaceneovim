local clone = require("domain.utils.table").clone
local chatbot = require("domain.contracts.controller_registry").chatbot()
---@return KeyBind[]
return function()
  ---@type KeyBind[]
  local content = {
    { key = "$", mode = { "n" },                          description = "Toggle",                     method = chatbot.toggle() },
    { key = "o", description = "Open",                    method = chatbot.open() },
    { key = "c", description = "Close",                   method = chatbot.close() },
    { key = "cC", description = "Prompts",                method = chatbot.prompt() },
    { key = "f", description = "Send file",               method = chatbot.send("file") },
    { key = "b", description = "Send buffers",            method = chatbot.send("buffer") },
    { key = "s", mode = { "n", "v" },                     description = "Send context",               method = chatbot.send() },
    { key = "S", mode = { "v" },                          description = "Send selection",             method = chatbot.send("selection") },
    { key = "d", description = "Send line diagnostics",   method = chatbot.send("line_diagnostics") },
    { key = "D", description = "Send buffer diagnostics", method = chatbot.send("buffer_diagnostics") },
    { key = "P", description = "Change agent",            method = chatbot.switch() },
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
    local bind = clone(entry)
    bind.key = "<leader>$" .. bind.key
    bind.mode = bind.mode or "n"
    bind.buffer = nil
    bind.silent = true
    bind.noremap = true
    bind.nowait = false
    table.insert(result, bind)
  end

  return result

  -- Spacemacs-inspired AI keybinding reference
  --
  -- SPC $ $   Toggle
  -- SPC $ a   Add text to context
  -- SPC $ b   Send buffer to AI
  -- SPC $ c c Generate code
  -- SPC $ c C Custom code instructions
  -- SPC $ c d Document code
  -- SPC $ c e Explain code
  -- SPC $ c f Fix code
  -- SPC $ c i Improve code
  -- SPC $ d   Define word
  -- SPC $ D   Domain-specific tasks
  -- SPC $ e   Edit text prompt
  -- SPC $ E   Create embedding
  -- SPC $ f   Add file to context
  -- SPC $ F   Focus chat window
  -- SPC $ g   Open chat session
  -- SPC $ G   Toggle chat window
  -- SPC $ h   Hide chat window
  -- SPC $ i d DALL-E request
  -- SPC $ i e Edit existing image
  -- SPC $ i i Generate image
  -- SPC $ i v Create image variation
  -- SPC $ l   List all models
  -- SPC $ L   Retrieve specific model details
  -- SPC $ m   Configuration menu
  -- SPC $ o p Set Org-mode properties
  -- SPC $ o t Set Org-mode topic
  -- SPC $ p   Choose LLM provider
  -- SPC $ q   Close session
  -- SPC $ r   Rewrite/refactor selection
  -- SPC $ R   Reasoning tasks
  -- SPC $ s   Send message
  -- SPC $ S   Manage sessions
  -- SPC $ t   Translate text
  -- SPC $ u   Summarize text
  -- SPC $ v   Send selection to AI (visual)
  -- SPC $ w   Improve writing
  -- SPC $ x   Manage context
end
