---@type CompleterContract
local completer_controller = require("application.controllers.completer")
---@type HoverContract
local hover_controller = require("application.controllers.hover")
---@type JumperContract
local jumper_controller = require("application.controllers.jumper")
---@type EditorContract
local editor_controller = require("application.controllers.editor")

---@type KeyBind[]
local unprefixed_content = {
  { key = "<S-k>", description = "Hover",          method = hover_controller.toggle() },
  {
    key = "<C-Space>",
    mode = { "i", "c" },
    description = "Complete",
    method = completer_controller.complete(),
  },
  { key = "<M-j>", description = "Drag line down", method = editor_controller.drag({ direction = "down", mode = "normal" }) },
  { key = "<M-k>", description = "Drag line up",   method = editor_controller.drag({ direction = "up", mode = "normal" }) },
  { key = "{",     mode = { "n", "v" },            description = "Next paragraph",                                          method = editor_controller.paragraph({ direction = "next" }) },
  { key = "}",     mode = { "n", "v" },            description = "Previous paragraph",                                      method = editor_controller.paragraph({ direction = "previous" }) },
  { key = "p",     mode = { "v" },                 description = "Past",                                                    method = editor_controller.paste({ position = "before" }) },
  { key = "P",     mode = { "v" },                 description = "Past",                                                    method = editor_controller.paste({ position = "after" }) },
  {
    key = "<M-j>",
    mode = "v",
    description = "Drag line down",
    method = editor_controller.drag({ direction = "down", mode = "visual" }),
  },
  {
    key = "<M-k>",
    mode = "v",
    description = "Drag line up",
    method = editor_controller.drag({ direction = "up", mode = "visual" }),
  },
  {
    key = "<M-j>",
    mode = "i",
    description = "Drag line down",
    method = editor_controller.drag({ direction = "down", mode = "insert" }),
  },
  {
    key = "<M-k>",
    mode = "i",
    description = "Drag line up",
    method = editor_controller.drag({ direction = "up", mode = "insert" }),
  },
  {
    key = "<Esc>",
    mode = "t",
    description = "Go to normal mode",
    method = editor_controller.terminal_escape(),
  },
  { key = "<C-BS>", mode = { "i", "c" }, description = "Delete previous word", method = editor_controller.delete_word() },
  { key = "<C-H>",  mode = { "i", "c" }, description = "Delete previous word", method = editor_controller.delete_word() },
  {
    key = "r",
    mode = { "o" },
    description = "Remote jump",
    method = jumper_controller.remote(),
  },
  { key = "q", mode = { "n" }, description = "Dismiss hover", method = hover_controller.dismiss() },
}

vim.keymap.set("n", "k", function()
  return (vim.v.count > 0 and "m'" .. vim.v.count or "") .. "k"
end, { expr = true, silent = true })

vim.keymap.set("n", "j", function()
  return (vim.v.count > 0 and "m'" .. vim.v.count or "") .. "j"
end, { expr = true, silent = true })

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
  local bind = vim.deepcopy(content)
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
