local bufferline_ok, bufferline = pcall(require, "bufferline")
if not bufferline_ok then
  return vim.notify("Failed to load plugin `akinsho/bufferline.nvim`")
end

bufferline.setup({
  options = {
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
})

local bufdelete_ok, bufdelete = pcall(require, "bufdelete")
if not bufdelete_ok then
  return vim.notify("Failed to load plugin `famiu/bufdelete.nvim`")
end

local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  return vim.notify("Failed to load plugin `folke/snacks.nvim`")
end

return {
  snacks = snacks,
  bufferline = bufferline,
  bufdelete = bufdelete,
}
