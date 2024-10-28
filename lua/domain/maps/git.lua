local versior_controller = require("application.controllers.versior")

---@type KeyBind[]
local git_content = {
  { key = "s", description = "[s]tatus",       method = versior_controller.open() },
  { key = "S", description = "[S]tage file",   method = versior_controller.stage_file() },
  { key = "o", description = "Br[o]wse",       method = versior_controller.browse() },
  { key = "U", description = "[U]nstage file", method = versior_controller.unstage_file() },
  { key = "b", description = "[b]lame Line",   method = versior_controller.blame({ location = "line" }) },
}

---@type KeyBind[]
local branchs_content = {
  { key = "v",   description = "Version control" },
  { key = "vb",  description = "[b]ranches" },
  { key = "vbl", description = "Branch [l]og",   method = versior_controller.log() },
  { key = "vbs", description = "[s]witch",       method = versior_controller.branches() },
}

---@type KeyBind[]
local file_content = {
  { key = "f",  description = "File" },
  { key = "fl", description = "Blame [l]ines",           method = versior_controller.blame() },
  { key = "fn", description = "[n]ext changed file",     method = versior_controller.jump_file({ direction = "next" }) },
  { key = "fp", description = "[p]revious changed file", method = versior_controller.jump_file({ direction = "previous" }) },
}


local result = {}
local contents = {}
for _, content in pairs({
  git_content,
  branchs_content,
  file_content,
}) do
  for _, bind in pairs(content) do
    table.insert(contents, bind)
  end
end

table.insert(result, {
  key = "<leader>g",
  description = "Git",
  mode = "n",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})
for _, content in pairs(contents) do
  local bind = vim.deepcopy(content)
  bind.key = "<leader>g" .. bind.key
  bind.mode = "n"
  bind.buffer = nil
  bind.silent = true
  bind.noremap = true
  bind.nowait = false
  table.insert(result, bind)
end

return result
