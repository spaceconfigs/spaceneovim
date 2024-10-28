local window_controller = require("application.controllers.window")
local zen_controller = require("application.controllers.zen")
local notification_controller = require("application.controllers.notification")

local center_content = {
  { key = "c",  description = "Center" },
  { key = "cC", description = "Buffer ([C]enter)", method = zen_controller.center() },
  { key = "ca", description = "[a]rea",            mode = "v",                      method = zen_controller.area() },
  { key = "cz", description = "[z]en",             method = zen_controller.toggle() },
}

local pop_content = {
  { key = "p",  description = "Pop-up" },
  { key = "pm", description = "Show [m]essage history", method = notification_controller.list() },
  { key = "pP", description = "Dismiss messages ([P])", method = notification_controller.dismiss() },
}

local window_content = {
  { key = "d", description = "[d]elete",                 method = window_controller.close() },
  { key = "h", mode = { "n", "i", "t" },                 description = "Go left ([h])",                                               method = window_controller.go({ direction = "left" }) },
  { key = "H", description = "Move to left ([H])",       method = window_controller.move({ direction = "left" }) },
  { key = "j", mode = { "n", "i", "t" },                 description = "Go down ([j])",                                               method = window_controller.go({ direction = "down" }) },
  { key = "J", description = "Move down ([J])",          method = window_controller.move({ direction = "down" }) },
  { key = "k", mode = { "n", "i", "t" },                 description = "Go up ([k])",                                                 method = window_controller.go({ direction = "up" }) },
  { key = "K", description = "Move up ([K])",            method = window_controller.move({ direction = "up" }) },
  { key = "l", mode = { "n", "i", "t" },                 description = "Go right ([l])",                                              method = window_controller.go({ direction = "right" }) },
  { key = "L", description = "Move right ([L])",         method = window_controller.move({ direction = "right" }) },
  { key = "m", description = "[m]aximize",               method = window_controller.toggle() },
  { key = "s", description = "[s]plit below",            method = window_controller.split({ type = "split", previous = true }) },
  { key = "v", description = "Split right ([v]ertical)", method = window_controller.split({ type = "vsplit", previous = true }) },
  { key = "t", description = "Dedicate ([t]ag)",         method = window_controller.dedicate() },
  { key = "S", description = "[S]plit below",            method = window_controller.split({ type = "split" }) },
  { key = "V", description = "Split right ([V]ertical)", method = window_controller.split({ type = "vsplit" }) },
  { key = "[", description = "Expand width ([)",         method = window_controller.resize_transient({ axis = "width", delta = 5 }) },
  { key = "]", description = "Shrink width (])",         method = window_controller.resize_transient({ axis = "width", delta = -5 }) },
  { key = "{", description = "Expand height ({)",        method = window_controller.resize_transient({ axis = "height", delta = 5 }) },
  { key = "}", description = "Shrink height (})",        method = window_controller.resize_transient({ axis = "height", delta = -5 }) },
  { key = "=", description = "Balance area (=)",         method = window_controller.balance_area() },
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
  local bind = vim.deepcopy(content)
  bind.key = "<leader>w" .. bind.key
  bind.mode = bind.mode or "n"
  bind.buffer = nil
  bind.silent = true
  bind.noremap = true
  bind.nowait = false
  table.insert(result, bind)
end

return result
