local clone = require("domain.utils.table").clone
local notification = require("domain.contracts.registry").notification()
local window = require("domain.contracts.registry").window()
local zen = require("domain.contracts.registry").zen()
---@return KeyBind[]
return function()
  ---@type KeyBind[]
  local center_content = {
    { key = "c",  description = "Center" },
    { key = "cC", description = "Buffer ([C]enter)", method = zen.center() },
    { key = "ca", description = "[a]rea",            mode = "v",                       method = zen.area() },
    { key = "cz", description = "[z]en",             method = zen.toggle() },
  }

  ---@type KeyBind[]
  local pop_content = {
    { key = "p",  description = "Pop-up" },
    { key = "pm", description = "Show [m]essage history", method = notification.list() },
    { key = "pP", description = "Dismiss messages ([P])", method = notification.dismiss() },
  }

  ---@type KeyBind[]
  local window_content = {
    { key = "d", description = "[d]elete",                 method = window.close() },
    { key = "h", mode = { "n", "i", "t" },                 description = "Go left ([h])",                                                method = window.go({ direction = "left" }) },
    { key = "H", description = "Move to left ([H])",       method = window.move({ direction = "left" }) },
    { key = "j", mode = { "n", "i", "t" },                 description = "Go down ([j])",                                                method = window.go({ direction = "down" }) },
    { key = "J", description = "Move down ([J])",          method = window.move({ direction = "down" }) },
    { key = "k", mode = { "n", "i", "t" },                 description = "Go up ([k])",                                                  method = window.go({ direction = "up" }) },
    { key = "K", description = "Move up ([K])",            method = window.move({ direction = "up" }) },
    { key = "l", mode = { "n", "i", "t" },                 description = "Go right ([l])",                                               method = window.go({ direction = "right" }) },
    { key = "L", description = "Move right ([L])",         method = window.move({ direction = "right" }) },
    { key = "m", description = "[m]aximize",               method = window.toggle() },
    { key = "s", description = "[s]plit below",            method = window.split({ type = "split", previous = true }) },
    { key = "v", description = "Split right ([v]ertical)", method = window.split({ type = "vsplit", previous = true }) },
    { key = "t", description = "Dedicate ([t]ag)",         method = window.dedicate() },
    { key = "S", description = "[S]plit below",            method = window.split({ type = "split" }) },
    { key = "V", description = "Split right ([V]ertical)", method = window.split({ type = "vsplit" }) },
    { key = "[", description = "Expand width ([)",         method = window.resize_transient({ axis = "width", delta = 5 }) },
    { key = "]", description = "Shrink width (])",         method = window.resize_transient({ axis = "width", delta = -5 }) },
    { key = "{", description = "Expand height ({)",        method = window.resize_transient({ axis = "height", delta = 5 }) },
    { key = "}", description = "Shrink height (})",        method = window.resize_transient({ axis = "height", delta = -5 }) },
    { key = "=", description = "Balance area (=)",         method = window.balance_area() },
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
    description = "Project",
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
