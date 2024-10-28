local clone = require("domain.utils.table").clone
local completer = require("domain.contracts.controller_registry").completer()
local editor = require("domain.contracts.controller_registry").editor()
local hover = require("domain.contracts.controller_registry").hover()
local jumper = require("domain.contracts.controller_registry").jumper()
local window = require("domain.contracts.controller_registry").window()
---@return KeyBind[]
return function()
  ---@type KeyBind[]
  local unprefixed_content = {
    { key = "<S-k>", description = "Hover",          method = hover.toggle() },
    {
      key = "<C-A-v>",
      mode = { "n", "v" },
      description = "Scroll next window down",
      method = window.scroll({ direction = "down" }),
    },
    {
      key = "<C-A-S-v>",
      mode = { "n", "v" },
      description = "Scroll next window up",
      method = window.scroll({ direction = "up" }),
    },
    {
      key = "<C-Space>",
      mode = { "i", "c" },
      description = "Complete",
      method = completer.complete(),
    },
    { key = "<M-j>", description = "Drag line down", method = editor.drag({ direction = "down", mode = "normal" }) },
    { key = "<M-k>", description = "Drag line up",   method = editor.drag({ direction = "up", mode = "normal" }) },
    { key = "{",     mode = { "n", "v" },            description = "Next paragraph",                                          method = editor.paragraph({ direction = "next" }) },
    { key = "}",     mode = { "n", "v" },            description = "Previous paragraph",                                      method = editor.paragraph({ direction = "previous" }) },
    { key = "p",     mode = { "v" },                 description = "Past",                                                    method = editor.paste({ position = "before" }) },
    { key = "P",     mode = { "v" },                 description = "Past",                                                    method = editor.paste({ position = "after" }) },
    {
      key = "<M-j>",
      mode = "v",
      description = "Drag line down",
      method = editor.drag({ direction = "down", mode = "visual" }),
    },
    {
      key = "<M-k>",
      mode = "v",
      description = "Drag line up",
      method = editor.drag({ direction = "up", mode = "visual" }),
    },
    {
      key = "<M-j>",
      mode = "i",
      description = "Drag line down",
      method = editor.drag({ direction = "down", mode = "insert" }),
    },
    {
      key = "<M-k>",
      mode = "i",
      description = "Drag line up",
      method = editor.drag({ direction = "up", mode = "insert" }),
    },
    {
      key = "<Esc>",
      mode = "t",
      description = "Go to normal mode",
      method = editor.terminal_escape(),
    },
    { key = "<C-BS>", mode = { "i", "c" }, description = "Delete previous word", method = editor.delete_word() },
    { key = "<C-H>",  mode = { "i", "c" }, description = "Delete previous word", method = editor.delete_word() },
    {
      key = "r",
      mode = { "o" },
      description = "Remote jump",
      method = jumper.remote(),
    },
    { key = "q", mode = { "n" }, description = "Dismiss hover", method = hover.dismiss() },
  }

  local result = {}
  local contents = {}
  for _, content in pairs({
    unprefixed_content,
  }) do
    for _, bind in pairs(content) do
      table.insert(contents, bind)
    end
  end

  for _, content in pairs(contents) do
    local bind = clone(content)
    bind.key = content.key
    bind.prefix = ""
    bind.mode = content.mode or "n"
    bind.description = content.description or ""
    bind.buffer = nil
    bind.silent = true
    bind.noremap = true
    bind.nowait = false
    table.insert(result, bind)
  end

  return result
end
