local M = {}

local hook = require("domain.contracts.hook_registry").terminal()

local group = vim.api.nvim_create_augroup("TerminalGroup", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  pattern = "*",
  callback = function(args)
    hook.on_terminal_open(args)

    vim.api.nvim_buf_attach(args.buf, false, {
      on_lines = function(_, buf)
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(buf) then
            return
          end

          hook.on_terminal_output({ buf = buf })
        end)
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = group,
  pattern = "*",
  callback = function(args)
    hook.on_terminal_destroy({ buf = args.buf, status = vim.v.event.status })
  end,
})

return M
