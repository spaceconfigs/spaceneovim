local ok_fzf, fzf = pcall(require, "fzf-lua")
if not ok_fzf then
  return vim.notify("Failed to require load `ibhagwan/fzf-lua`")
end

return {
  fzf = fzf,
}
