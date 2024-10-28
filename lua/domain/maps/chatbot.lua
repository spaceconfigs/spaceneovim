local clone = require("domain.utils.table").clone
local chatbot = require("domain.contracts.registry").chatbot()
---@return KeyBind[]
return function()
  ---@type KeyBind[]
  local content = {
    { key = "$", mode = { "n" },                      description = "Toggle",            method = chatbot.toggle() },
    { key = "s", mode = { "n", "v" },                 description = "Send prompt",       method = chatbot.send() },
    { key = "b", description = "Send buffer",         method = chatbot.add_buffer() },
    { key = "g", description = "Open chat session",   method = chatbot.toggle() },
    { key = "q", description = "Close session",       method = chatbot.toggle() },
    { key = "a", description = "Add text to context", method = chatbot.add() },
    { key = "f", description = "Add file to context", method = chatbot.add_file() },
    { key = "l", description = "Select model",        method = chatbot.select_model() },
    { key = "F", description = "Focus chat window",   method = chatbot.focus() },
    { key = "a", description = "Accept diff",         method = chatbot.diff_accept() },
    { key = "d", description = "Deny diff",           method = chatbot.diff_deny() },
    { key = "r", description = "Resume session",      method = chatbot.resume() },
    { key = "C", description = "Continue session",    method = chatbot.continue() },
    { key = "S", description = "Status",              method = chatbot.status() },
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
  -- SPC $ s   Send message
  -- SPC $ b   Send buffer to AI
  -- SPC $ v   Send selection to AI (visual)
  -- SPC $ g   Open chat session
  -- SPC $ q   Close session
  -- SPC $ m   Configuration menu
  -- SPC $ e   Edit text prompt
  -- SPC $ r   Rewrite/refactor selection
  -- SPC $ a   Add text to context
  -- SPC $ f   Add file to context
  -- SPC $ l   List all models
  -- SPC $ L   Retrieve specific model details
  -- SPC $ E   Create embedding
  -- SPC $ c c Generate code
  -- SPC $ c C Custom code instructions
  -- SPC $ c d Document code
  -- SPC $ c f Fix code
  -- SPC $ c e Explain code
  -- SPC $ c i Improve code
  -- SPC $ i i Generate image
  -- SPC $ i e Edit existing image
  -- SPC $ i v Create image variation
  -- SPC $ i d DALL-E request
  -- SPC $ o t Set Org-mode topic
  -- SPC $ o p Set Org-mode properties
  -- SPC $ S   Manage sessions
  -- SPC $ x   Manage context
  -- SPC $ p   Choose LLM provider
  -- SPC $ R   Reasoning tasks
  -- SPC $ D   Domain-specific tasks
  -- SPC $ t   Translate text
  -- SPC $ d   Define word
  -- SPC $ u   Summarize text
  -- SPC $ w   Improve writing
  -- SPC $ G   Toggle chat window
  -- SPC $ h   Hide chat window
  -- SPC $ F   Focus chat window
end
