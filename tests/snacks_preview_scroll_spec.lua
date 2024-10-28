-- Headless spec: snacks picker preview-scroll key overrides.
--   nvim --headless -u NONE -c "luafile tests/snacks_preview_scroll_spec.lua" -c "qa!"
package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path

local specs = require("infrastructure.plugins.lazy.configs")

local failures = 0
local function check(label, cond)
  print((cond and "ok   - " or "FAIL - ") .. label)
  if not cond then
    failures = failures + 1
  end
end

-- The snacks spec that owns the picker config (other snacks entries are bare dependencies).
local picker
for _, spec in ipairs(specs) do
  if spec[1] == "folke/snacks.nvim" and type(spec.opts) == "table" and spec.opts.picker then
    picker = spec.opts.picker
  end
end

check("found the snacks spec carrying picker opts", picker ~= nil)
if not picker then
  vim.cmd("cq")
  return
end

local win = picker.win or {}

for _, name in ipairs({ "input", "list", "preview" }) do
  local keys = win[name] and win[name].keys
  check(name .. " window defines a keys table", type(keys) == "table")
end

-- Input window: action plus insert+normal mode, because the prompt is in insert mode.
local input = (win.input or {}).keys or {}
local down, up = input["<C-A-v>"], input["<C-A-S-v>"]
check("input <C-A-v> scrolls preview down", type(down) == "table" and down[1] == "preview_scroll_down")
check("input <C-A-S-v> scrolls preview up", type(up) == "table" and up[1] == "preview_scroll_up")
for _, entry in ipairs({ { "<C-A-v>", down }, { "<C-A-S-v>", up } }) do
  local label, bind = entry[1], entry[2]
  local modes = type(bind) == "table" and bind.mode or {}
  local has_i, has_n = false, false
  for _, m in ipairs(modes) do
    has_i = has_i or m == "i"
    has_n = has_n or m == "n"
  end
  check("input " .. label .. " is bound in insert and normal mode", has_i and has_n)
end

-- List and preview windows: bare action strings, normal mode only.
for _, name in ipairs({ "list", "preview" }) do
  local keys = (win[name] or {}).keys or {}
  check(name .. " <C-A-v> scrolls preview down", keys["<C-A-v>"] == "preview_scroll_down")
  check(name .. " <C-A-S-v> scrolls preview up", keys["<C-A-S-v>"] == "preview_scroll_up")
end

-- Snacks' own preview-scroll defaults are disabled outright, not shadowed.
for _, name in ipairs({ "input", "list" }) do
  local keys = (win[name] or {}).keys or {}
  check(name .. " disables <c-b>", keys["<c-b>"] == false)
  check(name .. " disables <c-f>", keys["<c-f>"] == false)
end

-- List scrolling is out of scope and must survive untouched.
for _, name in ipairs({ "input", "list", "preview" }) do
  local keys = (win[name] or {}).keys or {}
  check(name .. " leaves <c-d> alone", keys["<c-d>"] == nil)
  check(name .. " leaves <c-u> alone", keys["<c-u>"] == nil)
end

-- Guard the notation trap: <C-A-V> collapses onto <C-A-v> and must never be used.
for _, name in ipairs({ "input", "list", "preview" }) do
  local keys = (win[name] or {}).keys or {}
  check(name .. " does not use the ambiguous <C-A-V> notation", keys["<C-A-V>"] == nil)
end

if failures > 0 then
  vim.cmd("cq")
end
