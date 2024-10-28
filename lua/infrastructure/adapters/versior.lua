local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.plugin_registry").versior()
local gitsigns = plugin.gitsigns
local neogit = plugin.neogit
local snacks = plugin.snacks
local tardis = plugin.tardis

---@type VersiorPort
local M = {
  blame = function(opts)
    if opts.location == "file" then
      -- codediff only exposes its history view as a user command; the module is
      -- required in `infrastructure/plugins/versior.lua` so it is loaded first.
      return vim.cmd("CodeDiff history %")
    end

    gitsigns.blame_line()
  end,

  open = function()
    neogit.open({ kind = "auto" })
  end,

  stage_files = function()
    local filepath = vim.fn.expand("%:p")
    vim.fn.system("git ls-files --error-unmatch " .. vim.fn.shellescape(filepath) .. " 2>/dev/null")
    if vim.v.shell_error ~= 0 then
      return vim.fn.system("git add " .. vim.fn.shellescape(filepath))
    end

    gitsigns.stage_buffer()
  end,

  unstage_files = function()
    gitsigns.undo_stage_hunk()
  end,

  browse = function()
    snacks.gitbrowse()
  end,

  branches = function()
    snacks.picker.git_branches()
  end,

  log = function()
    snacks.picker.git_log()
  end,

  jump_file = function(opts)
    local output = vim.fn.systemlist("git diff --name-only HEAD")
    if vim.v.shell_error ~= 0 or #output == 0 then
      return vim.notify("No changed files", vim.log.levels.INFO)
    end

    local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    local current = vim.fn.expand("%:p")
    local index = 0
    for i, relative in ipairs(output) do
      if root .. "/" .. relative == current then
        index = i
        break
      end
    end

    local step = opts.direction == "previous" and -1 or 1
    local target = output[(index - 1 + step) % #output + 1]
    vim.cmd("edit " .. vim.fn.fnameescape(root .. "/" .. target))
  end,

  time_machine = function()
    tardis.tardis()
  end,
}

return make_logged("adapters/versior", M)
