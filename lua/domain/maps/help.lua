local clone = require("domain.utils.table").clone
local searcher = require("domain.contracts.controller_registry").searcher()
---@return KeyBind[]
return function()
  ---@type KeyBind[]
  local help_content = {
  }

  local contents = {}
  local result = {}
  for _, content in pairs({
    help_content,
  }) do
    for _, bind in pairs(content) do
      table.insert(contents, bind)
    end
  end

  table.insert(result, {
    key = "<leader>h",
    description = "Help",
    mode = "n",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })

  for _, content in pairs(contents) do
    local bind = clone(content)
    bind.key = "<leader>h" .. bind.key
    bind.mode = "n"
    bind.buffer = nil
    bind.silent = true
    bind.noremap = true
    bind.nowait = false
    table.insert(result, bind)
  end

  table.insert(result, {
    key = "<leader><C-h>",
    description = "Keymaps",
    mode = "n",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })

  table.insert(result, {
    key = "<leader><C-h>h",
    description = "List keymaps",
    method = searcher.keymaps(),
    mode = "n",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })

  return result
end
