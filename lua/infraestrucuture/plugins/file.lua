local ok_fzf, fzf = pcall(require, "fzf-lua")
if not ok_fzf then
  return vim.notify("Failed to require load `ibhagwan/fzf-lua`")
end

local fzf_opts = require("infraestrucuture.plugins.lazy.settings.fzf-lua")
fzf.setup(fzf_opts.horizontal)

return {
  fzf = fzf,
}
