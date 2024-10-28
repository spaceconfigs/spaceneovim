local clone = require("domain.utils.table").clone
---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
  ---@type KeyBind[]
  local bookmark_content = {
    { key = "b",  description = "Bookmark" },
    { key = "ba", description = "[a]dd Bookmark",    method = controllers.bookmarker.add() },
    { key = "bb", description = "List [b]ookmarks",  method = controllers.bookmarker.list() },
    { key = "bd", description = "[d]elete Bookmark", method = controllers.bookmarker.remove() },
  }

  ---@type KeyBind[]
  local config_content = {
    { key = "e",  description = "Config" },
    { key = "ed", description = "E[d]it Config",     method = controllers.file.edit_config() },
    { key = "eR", description = "[R]eload Config",   method = controllers.file.source_config() },
    { key = "eU", description = "[U]pdate Packages", method = controllers.packager.update() },
  }

  ---@type KeyBind[]
  local yank_content = {
    { key = "y",  description = "Copy" },
    { key = "yc", description = "[c]olumn", method = controllers.file.copy({ extensions = "type_line_column" }) },
    {
      key = "yC",
      description = "Project [C]olumn",
      method = controllers.file.copy({ location = "project", extensions = "type_line_column" }),
    },
    { key = "yd", description = "[d]irectory", method = controllers.file.copy({ item = "directory" }) },
    {
      key = "yD",
      description = "Project [D]irectory",
      method = controllers.file.copy({ item = "directory", location = "project" }),
    },
    { key = "yl", description = "[l]ine",      method = controllers.file.copy({ extensions = "type_line" }) },
    {
      key = "yL",
      description = "Name [L]ine",
      method = controllers.file.copy({ location = "file", extensions = "type_line" }),
    },
    { key = "yn", description = "[n]ame",                method = controllers.file.copy({ item = "file", location = "file" }) },
    {
      key = "yN",
      description = "[N]ame without extetion",
      method = controllers.file.copy({ item = "file", location = "file", extensions = "none" }),
    },
    { key = "yy", description = "Path ([y]ank)",         method = controllers.file.copy({ item = "file" }) },
    { key = "yY", description = "Project path ([Y]ank)", method = controllers.file.copy({ item = "file", location = "project" }) },
  }

  ---@type KeyBind[]
  local file_content = {
    { key = "D", description = "[D]elete",   method = controllers.file.delete_current() },
    { key = "f", description = "[f]ind",     method = controllers.file.list({ location = "file" }) },
    { key = "r", description = "[r]ecents",  method = controllers.file.oldfiles() },
    { key = "R", description = "[R]ename",   method = controllers.file.rename() },
    { key = "s", description = "[s]ave",     method = controllers.file.save() },
    { key = "S", description = "[S]ave All", method = controllers.file.save_all() },
    { key = "t", description = "[t]ree",     method = controllers.tree.toggle({ location = "file" }) },
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
