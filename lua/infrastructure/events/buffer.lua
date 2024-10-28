local M = {}

local hook = require("domain.contracts.hook_registry").buffer()

vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('BufferGroup', { clear = true }),
  callback = function()
    hook.onBufferInit()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('BufferInitGroup', { clear = true }),
  callback = function(args)
    hook.onFiletypeInit(args.match)
  end,
})

return M
