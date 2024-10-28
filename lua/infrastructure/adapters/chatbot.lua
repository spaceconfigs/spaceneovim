local make_logged = require("application.helpers.make_logged")
local chatbot_plugins = require("infrastructure.plugins.plugin_registry").chatbot()
local cli = chatbot_plugins.sidekick

---@type ChatbotPort
local M = {
  toggle = function()
    cli.toggle({ name = "claude" })
  end,
  open = function()
    cli.show({ name = "claude", focus = true })
  end,
  close = function()
    cli.close({ name = "claude" })
  end,
  send = function(target)
    if target == "file" then
      cli.send({ name = "claude", msg = "{file}" })
      return
    end
    if target == "buffer" then
      cli.send({ name = "claude", msg = "{buffers}" })
      return
    end
    if target == "selection" then
      cli.send({ name = "claude", msg = "{selection}" })
      return
    end
    if target == "line_diagnostics" then
      cli.send({ name = "claude", msg = "{diagnostics}" })
      return
    end
    if target == "buffer_diagnostics" then
      cli.send({ name = "claude", msg = "{diagnostics_all}" })
      return
    end
    cli.send({ name = "claude", msg = "{this}" })
  end,
  switch = function()
    -- sidekick has no model switch; `select` picks which CLI tool/agent to attach.
    cli.select()
  end,
}

return make_logged("adapters/chatbot", M)
