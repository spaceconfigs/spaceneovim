local clone = require("domain.utils.table").clone
local bookmarker = require("domain.contracts.controller_registry").bookmarker()
local file = require("domain.contracts.controller_registry").file()
local packager = require("domain.contracts.controller_registry").packager()
local tree = require("domain.contracts.controller_registry").tree()
---@return KeyBind[]
return function()
  ---@type KeyBind[]
  local bookmark_content = {
    { key = "b",  description = "Bookmark" },
    { key = "ba", description = "Add Bookmark",    method = bookmarker.add() },
    { key = "bb", description = "List bookmarks",  method = bookmarker.list() },
    { key = "bd", description = "Delete Bookmark", method = bookmarker.remove() },
  }

  ---@type KeyBind[]
  local config_content = {
    { key = "e",  description = "Config" },
    { key = "ed", description = "Edit Config",     method = file.edit_config() },
    { key = "eR", description = "Reload Config",   method = file.source_config() },
    { key = "eU", description = "Update Packages", method = packager.update() },
  }

  ---@type KeyBind[]
  local yank_content = {
    { key = "y",  description = "Copy" },
    { key = "yc", description = "Column", method = file.copy({ extensions = "type_line_column" }) },
    {
      key = "yC",
      description = "Project Column",
      method = file.copy({ location = "project", extensions = "type_line_column" }),
    },
    { key = "yd", description = "Directory", method = file.copy({ item = "directory" }) },
    {
      key = "yD",
      description = "Project Directory",
      method = file.copy({ item = "directory", location = "project" }),
    },
    { key = "yl", description = "Line",      method = file.copy({ extensions = "type_line" }) },
    {
      key = "yL",
      description = "Name Line",
      method = file.copy({ location = "file", extensions = "type_line" }),
    },
    { key = "yn", description = "Name",                method = file.copy({ item = "file", location = "file" }) },
    {
      key = "yN",
      description = "Name without extetion",
      method = file.copy({ item = "file", location = "file", extensions = "none" }),
    },
    { key = "yy", description = "Path (yank)",         method = file.copy({ item = "file" }) },
    { key = "yY", description = "Project path (Yank)", method = file.copy({ item = "file", location = "project" }) },
  }

  ---@type KeyBind[]
  local file_content = {
    { key = "D", description = "Delete",   method = file.delete_current() },
    { key = "f", description = "Find",     method = file.list({ location = "file" }) },
    { key = "r", description = "Recents",  method = file.oldfiles() },
    { key = "R", description = "Rename",   method = file.rename() },
    { key = "s", description = "Save",     method = file.save() },
    { key = "S", description = "Save All", method = file.save_all() },
    { key = "t", description = "Tree",     method = tree.toggle({ location = "file" }) },
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
