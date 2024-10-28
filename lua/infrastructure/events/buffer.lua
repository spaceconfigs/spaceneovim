local M = {}

local hook = require("domain.contracts.hook_registry").buffer()

vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('BufferGroup', { clear = true }),
  callback = function()
    hook.on_buffer_init()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('BufferInitGroup', { clear = true }),
  callback = function(args)
    hook.on_filetype_init(args.match)
  end,
})

return M
