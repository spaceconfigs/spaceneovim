local clone = require("domain.utils.table").clone
local notification = require("domain.contracts.controller_registry").notification()
local window = require("domain.contracts.controller_registry").window()
local keymapper = require("domain.contracts.controller_registry").keymapper()
local zen = require("domain.contracts.controller_registry").zen()
---@return KeyBind[]
return function()
  ---@type KeyBind[]
  local center_content = {
    { key = "c",  description = "Center" },
    { key = "cC", description = "Buffer (Center)", method = zen.center() },
    { key = "ca", description = "Area",            mode = "v",           method = zen.area() },
    { key = "cz", description = "Zen",             method = zen.toggle() },
  }

  ---@type KeyBind[]
  local pop_content = {
    { key = "p",  description = "Pop-up", },
    { key = "pm", description = "Show message history", method = notification.list() },
    { key = "pP", description = "Dismiss messages",     method = notification.dismiss() },
  }

  ---@type KeyBind[]
  local window_content = {
    { key = ".", description = "Transient",              method = keymapper.activate_transient({ keys = "<leader>w" }) },
    { key = "d", description = "Delete",                 method = window.close() },
    { key = "h", mode = { "n", "i", "t" },               description = "Go left",                                      method = window.go({ direction = "left" }) },
    { key = "H", description = "Move to left",           method = window.move({ direction = "left" }) },
    { key = "j", mode = { "n", "i", "t" },               description = "Go down",                                      method = window.go({ direction = "down" }) },
    { key = "J", description = "Move down",              method = window.move({ direction = "down" }) },
    { key = "k", mode = { "n", "i", "t" },               description = "Go up",                                        method = window.go({ direction = "up" }) },
    { key = "K", description = "Move up",                method = window.move({ direction = "up" }) },
    { key = "l", mode = { "n", "i", "t" },               description = "Go right",                                     method = window.go({ direction = "right" }) },
    { key = "L", description = "Move right",             method = window.move({ direction = "right" }) },
    { key = "m", description = "Maximize",               method = window.toggle() },
    { key = "s", description = "Split below",            method = window.split({ type = "split", previous = true }) },
    { key = "S", description = "Split below",            method = window.split({ type = "split" }) },
    { key = "v", description = "Split right (vertical)", method = window.split({ type = "vsplit", previous = true }) },
    { key = "V", description = "Split right (Vertical)", method = window.split({ type = "vsplit" }) },
    { key = "[", description = "Expand width ([)",       method = window.resize({ axis = "width", delta = 5 }) },
    { key = "]", description = "Shrink width (])",       method = window.resize({ axis = "width", delta = -5 }) },
    { key = "{", description = "Expand height ({)",      method = window.resize({ axis = "height", delta = 5 }) },
    { key = "}", description = "Shrink height (})",      method = window.resize({ axis = "height", delta = -5 }) },
    { key = "=", description = "Balance area (=)",       method = window.balance_area() },
    { key = "1", description = "Layout: 1 window",       method = window.layout({ count = 1 }) },
    { key = "2", description = "Layout: 2 columns",      method = window.layout({ count = 2 }) },
    { key = "3", description = "Layout: 3 columns",      method = window.layout({ count = 3 }) },
    { key = "4", description = "Layout: 2x2 grid",       method = window.layout({ count = 4 }) },
  }

  local result = {}
  local contents = {}
  for _, content in pairs({
    pop_content,
    window_content,
    center_content,
  }) do
    for _, bind in pairs(content) do
      table.insert(contents, bind)
    end
  end

  table.insert(result, {
    key = "<leader>w",
    description = "Window",
    mode = "n",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })
  for _, content in pairs(contents) do
    local bind = clone(content)
    bind.key = "<leader>w" .. bind.key
    bind.mode = bind.mode or "n"
    bind.buffer = nil
    bind.silent = true
    bind.noremap = true
    bind.nowait = false
    table.insert(result, bind)
  end

  return result
end
