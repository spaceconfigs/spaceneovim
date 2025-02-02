local okay = pcall(require, "fzf-lua")
if not okay then
  return vim.notify("Failed to require load `ibhagwan/fzf-lua`")
end

local live_grep = {
  rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
  fzf_opts = {
    ["--delimiter"] = "[\\):]",
    ['--with-nth'] = '1,4',
  },
}

local lgrep_curbuf = {
  rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
  fzf_opts = {
    ["--delimiter"] = "[\\):]",
    ['--with-nth'] = '4..',
  },
}

local horizontal = {
  cwd_prompt = false,
  prompt     = "> ",
  winopts    = {
    height  = 0.85,
    width   = 0.85,
    preview = {
      layout = 'vertical',
      vertical = 'up:70%',
    },
  },
}

return {
  horizontal = horizontal,
  live_grep = live_grep,
  lgrep_curbuf = lgrep_curbuf,
}
