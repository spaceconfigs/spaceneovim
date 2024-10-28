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

  copy_branch = function()
    local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
    if vim.v.shell_error ~= 0 or not branch or branch == "" then
      return vim.notify("Not in a git repository", vim.log.levels.ERROR)
    end

    vim.fn.setreg("+", branch)
    vim.notify("Copied " .. branch, vim.log.levels.INFO)
  end,

  copy_pull_request = function()
    local utils = require("octo.utils")

    if utils.get_current_buffer() then
      return require("octo.commands").copy_url()
    end

    local gh = require("octo.gh")
    gh.pr.view({
      json = "url",
      jq = ".url",
      opts = {
        cb = gh.create_callback({
          success = utils.copy_url,
          failure = function()
            vim.notify("No pull request for the current branch", vim.log.levels.ERROR)
          end,
        }),
      },
    })
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
    require("octo.reviews").start_or_resume_review()
  end,

  pull_request = function()
    local utils = require("octo.utils")
    utils.get_pull_request_for_current_branch(function(pr)
      vim.cmd("edit " .. utils.get_pull_request_uri(pr.number, pr.repo))
    end)
  end,

  browse_pull_request = function()
    if require("octo.utils").get_current_buffer() then
      return require("octo.navigation").open_in_browser()
    end

    require("octo.gh").pr.view({
      web = true,
      opts = {
        cb = function(_, stderr, status)
          if status == 0 then
            return
          end

          local message = stderr
          if message == nil or message == "" then
            message = "No pull request for the current branch"
          end

          vim.notify(message, vim.log.levels.ERROR)
        end,
      },
    })
  end,

  pull_requests = function(opts)
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

    local reviewed = (opts or {}).reviewed
    if reviewed == false then
      table.insert(filters, "-reviewed-by:@me")
    elseif reviewed == true then
      table.insert(filters, "reviewed-by:@me")
    end

    local label = (opts or {}).label
    if label then
      table.insert(filters, string.format('label:"%s"', label))
    end

    require("octo.picker").search({ prompt = table.concat(filters, " ") })
  end,

  reload_pull_request = function()
    require("octo.commands").reload({ verbose = true })
  end,

  notifications = function(opts)
    local status = (opts or {}).status or "unread"
    require("octo.picker").notifications({ status = status, all = status ~= "unread" })
  end,
}

return make_logged("adapters/versior", M)
