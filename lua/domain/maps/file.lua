local clone = require("domain.utils.table").clone
local bookmarker = require("domain.contracts.registry").bookmarker()
local file = require("domain.contracts.registry").file()
local packager = require("domain.contracts.registry").packager()
local tree = require("domain.contracts.registry").tree()
---@return KeyBind[]
return function()
  ---@type KeyBind[]
  local bookmark_content = {
    { key = "b",  description = "Bookmark" },
    { key = "ba", description = "[a]dd Bookmark",    method = bookmarker.add() },
    { key = "bb", description = "List [b]ookmarks",  method = bookmarker.list() },
    { key = "bd", description = "[d]elete Bookmark", method = bookmarker.remove() },
  }

  ---@type KeyBind[]
  local config_content = {
    { key = "e",  description = "Config" },
    { key = "ed", description = "E[d]it Config",     method = file.edit_config() },
    { key = "eR", description = "[R]eload Config",   method = file.source_config() },
    { key = "eU", description = "[U]pdate Packages", method = packager.update() },
  }

  ---@type KeyBind[]
  local yank_content = {
    { key = "y",  description = "Copy" },
    { key = "yc", description = "[c]olumn", method = file.copy({ extensions = "type_line_column" }) },
    {
      key = "yC",
      description = "Project [C]olumn",
      method = file.copy({ location = "project", extensions = "type_line_column" }),
    },
    { key = "yd", description = "[d]irectory", method = file.copy({ item = "directory" }) },
    {
      key = "yD",
      description = "Project [D]irectory",
      method = file.copy({ item = "directory", location = "project" }),
    },
    { key = "yl", description = "[l]ine",      method = file.copy({ extensions = "type_line" }) },
    {
      key = "yL",
      description = "Name [L]ine",
      method = file.copy({ location = "file", extensions = "type_line" }),
    },
    { key = "yn", description = "[n]ame",                method = file.copy({ item = "file", location = "file" }) },
    {
      key = "yN",
      description = "[N]ame without extetion",
      method = file.copy({ item = "file", location = "file", extensions = "none" }),
    },
    { key = "yy", description = "Path ([y]ank)",         method = file.copy({ item = "file" }) },
    { key = "yY", description = "Project path ([Y]ank)", method = file.copy({ item = "file", location = "project" }) },
  }

  ---@type KeyBind[]
  local file_content = {
    { key = "D", description = "[D]elete",   method = file.delete_current() },
    { key = "f", description = "[f]ind",     method = file.list({ location = "file" }) },
    { key = "r", description = "[r]ecents",  method = file.oldfiles() },
    { key = "R", description = "[R]ename",   method = file.rename() },
    { key = "s", description = "[s]ave",     method = file.save() },
    { key = "S", description = "[S]ave All", method = file.save_all() },
    { key = "t", description = "[t]ree",     method = tree.toggle({ location = "file" }) },
  }

  local result = {}
  local contents = {}
  for _, content in pairs({
    file_content,
    bookmark_content,
    config_content,
    yank_content,
  }) do
    for _, bind in pairs(content) do
      table.insert(contents, bind)
    end
  end

  table.insert(result, {
    key = "<leader>f",
    description = "File",
    mode = "n",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })

  for _, content in pairs(contents) do
    local bind = clone(content)
    bind.key = "<leader>f" .. bind.key
    bind.mode = "n"
    bind.buffer = nil
    bind.silent = true
    bind.noremap = true
    bind.nowait = false
    table.insert(result, bind)
  end

  return result
end
