local ok_gen, gen = pcall(require, "gen")
local ok_plenary, plenary = pcall(require, "plenary")
local ok_avante, avante = pcall(require, "avante")

if not ok_plenary then
  return vim.notify("Failed to load plugin `dpayne/CodeGPT.nvim`")
end

if not ok_avante then
  return vim.notify("Failed to load plugin `yetone/avante.nvim`")
end

vim.opt.laststatus = 3

return {
  avant = avante,
}
