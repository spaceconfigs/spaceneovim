local clone = require("domain.utils.table").clone
local searcher = require("domain.contracts.controller_registry").searcher()
local workspace = require("domain.contracts.controller_registry").workspace()
---@return KeyBind[]
return function()
  ---@type KeyBind[]
  local grep_input_content = {
    { key = "G",  description = "Grep input on project" },
    { key = "Gp", description = "Grep in [p]roject",    method = workspace.grep_input() },
  }

  ---@type KeyBind[]
  local search_content = {
    {
      key = "d",
      description = "[d]irectory",
      method = searcher.search({ location = "directory" }),
    },
    {
      key = "D",
      description = "[D]irectory w/ input",
      method = searcher.search_hover({ location = "directory" }),
    },
    { key = "l", description = "Resume ([l]ast)",   method = searcher.resume() },
    {
      key = "p",
      description = "Search in [p]roject",
      method = searcher.search({ location = "project", in_live = true }),
    },
    {
      key = "P",
      description = "Search [P]roject w/ input",
      method = searcher.search_hover({ location = "project" }),
    },
    { key = "s", description = "Text ([s]earch)",   method = searcher.search({ in_live = true }) },
    { key = "S", description = "[S]earch w/ input", method = searcher.search_hover() },
  }

  ---@type KeyBind[]
  local search_selection_content = {
    {
      key = "s",
      description = "Selection in buffer",
      method = searcher.search_selection(),
    },
    {
      key = "S",
      description = "Selection in project",
      method = searcher.search_selection({ location = "project" }),
    },
  }

  local result = {}
  table.insert(result, {
    key = "<leader>s",
    description = "Search",
    mode = "n",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })

  local contents = {}
  for _, content in pairs({
    grep_input_content,
    search_content,
  }) do
    for _, bind in pairs(content) do
      table.insert(contents, bind)
    end
  end

  for _, content in pairs(contents) do
    local bind = clone(content)
    bind.key = "<leader>s" .. bind.key
    bind.mode = "n"
    bind.buffer = nil
    bind.silent = true
    bind.noremap = true
    bind.nowait = false
    table.insert(result, bind)
  end

  table.insert(result, {
    key = "<leader>s",
    description = "Search",
    mode = "v",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })

  for _, content in pairs(search_selection_content) do
    local bind = clone(content)
    bind.key = "<leader>s" .. bind.key
    bind.mode = "v"
    bind.buffer = nil
    bind.silent = true
    bind.noremap = true
    bind.nowait = false
    table.insert(result, bind)
  end

  return result
end
