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

  review = function()
    -- octo is required in `infrastructure/plugins/versior.lua` so the plugin and
    -- its picker provider are set up before these submodules resolve.
    require("octo.reviews").start_or_resume_review()
  end,

  pull_request = function()
    local utils = require("octo.utils")
    utils.get_pull_request_for_current_branch(function(pr)
      vim.cmd("edit " .. utils.get_pull_request_uri(pr.number, pr.repo))
    end)
  end,

  pull_requests = function(opts)
    -- octo's `prs` picker queries `repository.pullRequests`, which has no draft
    -- or author filter, so the search picker is the only way to narrow both.
    local repo = require("octo.utils").get_remote_name()
    if not repo then
      return vim.notify("Cannot find repo", vim.log.levels.ERROR)
    end

    local author = (opts or {}).author
    local filters = { "repo:" .. repo, "is:pr", "is:open" }
    if author == "mine" then
      table.insert(filters, "author:@me")
    elseif author == "others" then
      table.insert(filters, "-author:@me")
    end

    if (opts or {}).drafts == false then
      table.insert(filters, "draft:false")
    end

    require("octo.picker").search({ prompt = table.concat(filters, " ") })
  end,

  reload_pull_request = function()
    require("octo.commands").reload({ verbose = true })
  end,

  notifications = function(opts)
    -- octo derives the REST `all` flag from the status the same way, so read and
    -- "all" listings must ask the API for read notifications too.
    local status = (opts or {}).status or "unread"
    require("octo.picker").notifications({ status = status, all = status ~= "unread" })
  end,
}

return make_logged("adapters/versior", M)
