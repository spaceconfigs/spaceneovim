local ok_notify, notify = pcall(require, "notify")
if not ok_notify then
  return vim.notify("Failed to load plugin `rcarriga/nvim-notify`")
end

local ok_telescope, telescope = pcall(require, "telescope")
if not ok_telescope then
  return vim.notify("Failed to load plugin `nvim-telescope/telescope.nvim`")
end

notify.setup({
  background_colour = "#000000",
})

notify.list = function()
  telescope.extensions.notify.notify({ layout_strategy = "vertical" })
end

return {
  notify = notify,
  telescope = telescope,
}
