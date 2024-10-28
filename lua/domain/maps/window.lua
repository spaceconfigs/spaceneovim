local clone = require("domain.utils.table").clone
---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
  ---@type KeyBind[]
  local center_content = {
    { key = "c",  description = "Center" },
    { key = "cC", description = "Buffer ([C]enter)", method = controllers.zen.center() },
    { key = "ca", description = "[a]rea",            mode = "v",                       method = controllers.zen.area() },
    { key = "cz", description = "[z]en",             method = controllers.zen.toggle() },
  }

  ---@type KeyBind[]
  local pop_content = {
    { key = "p",  description = "Pop-up" },
    { key = "pm", description = "Show [m]essage history", method = controllers.notification.list() },
    { key = "pP", description = "Dismiss messages ([P])", method = controllers.notification.dismiss() },
  }

  ---@type KeyBind[]
  local window_content = {
    { key = "d", description = "[d]elete",                 method = controllers.window.close() },
    { key = "h", mode = { "n", "i", "t" },                 description = "Go left ([h])",                                                method = controllers.window.go({ direction = "left" }) },
    { key = "H", description = "Move to left ([H])",       method = controllers.window.move({ direction = "left" }) },
    { key = "j", mode = { "n", "i", "t" },                 description = "Go down ([j])",                                                method = controllers.window.go({ direction = "down" }) },
    { key = "J", description = "Move down ([J])",          method = controllers.window.move({ direction = "down" }) },
    { key = "k", mode = { "n", "i", "t" },                 description = "Go up ([k])",                                                  method = controllers.window.go({ direction = "up" }) },
    { key = "K", description = "Move up ([K])",            method = controllers.window.move({ direction = "up" }) },
    { key = "l", mode = { "n", "i", "t" },                 description = "Go right ([l])",                                               method = controllers.window.go({ direction = "right" }) },
    { key = "L", description = "Move right ([L])",         method = controllers.window.move({ direction = "right" }) },
    { key = "m", description = "[m]aximize",               method = controllers.window.toggle() },
    { key = "s", description = "[s]plit below",            method = controllers.window.split({ type = "split", previous = true }) },
    { key = "v", description = "Split right ([v]ertical)", method = controllers.window.split({ type = "vsplit", previous = true }) },
    { key = "t", description = "Dedicate ([t]ag)",         method = controllers.window.dedicate() },
    { key = "S", description = "[S]plit below",            method = controllers.window.split({ type = "split" }) },
    { key = "V", description = "Split right ([V]ertical)", method = controllers.window.split({ type = "vsplit" }) },
    { key = "[", description = "Expand width ([)",         method = controllers.window.resize_transient({ axis = "width", delta = 5 }) },
    { key = "]", description = "Shrink width (])",         method = controllers.window.resize_transient({ axis = "width", delta = -5 }) },
    { key = "{", description = "Expand height ({)",        method = controllers.window.resize_transient({ axis = "height", delta = 5 }) },
    { key = "}", description = "Shrink height (})",        method = controllers.window.resize_transient({ axis = "height", delta = -5 }) },
    { key = "=", description = "Balance area (=)",         method = controllers.window.balance_area() },
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
