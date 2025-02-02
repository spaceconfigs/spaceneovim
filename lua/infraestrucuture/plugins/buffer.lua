local bufferline_ok, bufferline = pcall(require, "bufferline")
local bufdelete_ok, bufdelete = pcall(require, "bufdelete")
local ok_fzf, fzf = pcall(require, "fzf-lua")

if not bufferline_ok then
  return vim.notify("Failed to load plugin `akinsho/bufferline.nvim`")
end

if not bufdelete_ok then
  return vim.notify("Failed to load plugin `famiu/bufdelete.nvim`")
end

if not ok_fzf then
  return vim.notify("Failed to require load `ibhagwan/fzf-lua`")
end

bufferline.setup({
  options = {
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
})

local fzf_opts = require("infraestrucuture.plugins.lazy.settings.fzf-lua")
fzf.setup(fzf_opts.horizontal)

bufferline.list = function()
  fzf.buffers()
end

return {
  bufferline = bufferline,
  bufdelete = bufdelete,
}
