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
    { key = "pr", description = "Open review",   method = versior.review() },
    { key = "pp", description = "Ready PRs",     method = versior.pull_requests({ author = "others", drafts = false }) },
    { key = "pm", description = "My PRs",        method = versior.pull_requests({ author = "mine" }) },
    { key = "pP", description = "All PRs",       method = versior.pull_requests() },
    { key = "pR", description = "Pull request",  method = versior.pull_request() },
    { key = "pl", description = "Notifications", method = versior.notifications() },
    { key = "pL", description = "All notifications", method = versior.notifications({ status = "all" }) },
    { key = "p<C-r>", description = "Reload pull request", method = versior.reload_pull_request() },
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
