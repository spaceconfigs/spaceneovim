local ok_avante, avante = pcall(require, "avante")

if not ok_avante then
  error("Failed to load plugin `yetone/avante.nvim`")
end

vim.opt.laststatus = 3

return {
  avant = avante,
}
