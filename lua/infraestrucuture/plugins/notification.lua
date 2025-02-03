local ok_notify, notify = pcall(require, "notify")
if not ok_notify then
  return vim.notify("Failed to load plugin `rcarriga/nvim-notify`")
end

notify.setup({
  background_colour = "#000000",
})

local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  return vim.notify("Failed to load plugin `folke/snacks.nvim`")
end

return {
  notify = notify,
  snacks = snacks,
}
