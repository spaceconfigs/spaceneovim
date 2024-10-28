local bookmarker_controller = require("application.controllers.bookmarker")
local packager_controller = require("application.controllers.packager")
local file_controller = require("application.controllers.file")
local tree_controller = require("application.controllers.tree")

---@type KeyBind[]
local bookmark_content = {
  { key = "b",  description = "Bookmark" },
  { key = "ba", description = "[a]dd Bookmark",    method = bookmarker_controller.add() },
  { key = "bb", description = "List [b]ookmarks",  method = bookmarker_controller.list() },
  { key = "bd", description = "[d]elete Bookmark", method = bookmarker_controller.remove() },
}

---@type KeyBind[]
local config_content = {
  { key = "e",  description = "Config" },
  { key = "ed", description = "E[d]it Config",     method = file_controller.edit_config() },
  { key = "eR", description = "[R]eload Config",   method = file_controller.source_config() },
  { key = "eU", description = "[U]pdate Packages", method = packager_controller.update() },
}

---@type KeyBind[]
local yank_content = {
  { key = "y",  description = "Copy" },
  { key = "yc", description = "[c]olumn", method = file_controller.copy({ extensions = "type_line_column" }) },
  {
    key = "yC",
    description = "Project [C]olumn",
    method = file_controller.copy({ location = "project", extensions = "type_line_column" }),
  },
  { key = "yd", description = "[d]irectory", method = file_controller.copy({ item = "directory" }) },
  {
    key = "yD",
    description = "Project [D]irectory",
    method = file_controller.copy({ item = "directory", location = "project" }),
  },
  { key = "yl", description = "[l]ine",      method = file_controller.copy({ extensions = "type_line" }) },
  {
    key = "yL",
    description = "Name [L]ine",
    method = file_controller.copy({ location = "file", extensions = "type_line" }),
  },
  { key = "yn", description = "[n]ame",                method = file_controller.copy({ item = "file", location = "file" }) },
  {
    key = "yN",
    description = "[N]ame without extetion",
    method = file_controller.copy({ item = "file", location = "file", extensions = "none" }),
  },
  { key = "yy", description = "Path ([y]ank)",         method = file_controller.copy({ item = "file" }) },
  { key = "yY", description = "Project path ([Y]ank)", method = file_controller.copy({ item = "file", location = "project" }) },
}

---@type KeyBind[]
local file_content = {
  { key = "D", description = "[D]elete",   method = file_controller.delete_current() },
  { key = "f", description = "[f]ind",     method = file_controller.list({ location = "file" }) },
  { key = "r", description = "[r]ecents",  method = file_controller.oldfiles() },
  { key = "R", description = "[R]ename",   method = file_controller.rename() },
  { key = "s", description = "[s]ave",     method = file_controller.save() },
  { key = "S", description = "[S]ave All", method = file_controller.save_all() },
  { key = "t", description = "[t]ree",     method = tree_controller.toggle({ location = "file" }) },
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
  local bind = vim.deepcopy(content)
  bind.key = "<leader>f" .. bind.key
  bind.mode = "n"
  bind.buffer = nil
  bind.silent = true
  bind.noremap = true
  bind.nowait = false
  table.insert(result, bind)
end

return result
