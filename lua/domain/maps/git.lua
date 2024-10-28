local clone = require("domain.utils.table").clone
local versior = require("domain.contracts.controller_registry").versior()
---@return KeyBind[]
return function()
  ---@type KeyBind[]
  local git_content = {
    { key = "s", description = "Status",       method = versior.open() },
    { key = "S", description = "Stage file",   method = versior.stage_file() },
    { key = "o", description = "Browse",       method = versior.browse() },
    { key = "U", description = "Unstage file", method = versior.unstage_file() },
    { key = "b", description = "Blame Line",   method = versior.blame({ location = "line" }) },
    { key = "t", description = "Time machine", method = versior.time_machine() },
  }

  ---@type KeyBind[]
  local branchs_content = {
    { key = "v",   description = "Version control" },
    { key = "vb",  description = "Branches" },
    { key = "vbl", description = "Branch log",   method = versior.log() },
    { key = "vbs", description = "Switch",       method = versior.branches() },
  }

  ---@type KeyBind[]
  local review_content = {
    { key = "p",  description = "Review" },
    { key = "pR", description = "Open review",   method = versior.review() },
    { key = "pp", description = "Unreviewed PRs", method = versior.pull_requests({ author = "others", reviewed = false, drafts = false, label = "Ready for Review" }) },
    { key = "pm", description = "My PRs",        method = versior.pull_requests({ author = "mine" }) },
    { key = "pP", description = "PRs reviewed by me", method = versior.pull_requests({ author = "others", reviewed = true }) },
    { key = "pr", description = "Pull request",  method = versior.pull_request() },
    { key = "po", description = "Open in browser", method = versior.browse_pull_request() },
    { key = "pl", description = "Notifications", method = versior.notifications() },
    { key = "pL", description = "All notifications", method = versior.notifications({ status = "all" }) },
  }

  ---@type KeyBind[]
  local yank_content = {
    { key = "y",  description = "Yank" },
    { key = "yy", description = "Branch name", method = versior.copy_branch() },
    { key = "yp", description = "Pull request URL", method = versior.copy_pull_request() },
  }

  ---@type KeyBind[]
  local file_content = {
    { key = "f",  description = "File" },
    { key = "fl", description = "Commits log for current file", method = versior.blame() },
    { key = "fn", description = "Next changed file",          method = versior.jump_file({ direction = "next" }) },
    { key = "fp", description = "Previous changed file",      method = versior.jump_file({ direction = "previous" }) },
  }


  local result = {}
  local contents = {}
  for _, content in pairs({
    git_content,
    branchs_content,
    review_content,
    yank_content,
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
    local bind = clone(content)
    bind.key = "<leader>g" .. bind.key
    bind.mode = "n"
    bind.buffer = nil
    bind.silent = true
    bind.noremap = true
    bind.nowait = false
    table.insert(result, bind)
  end

  return result
end
