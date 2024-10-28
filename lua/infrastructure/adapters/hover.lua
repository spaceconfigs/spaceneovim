local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.hover")

---@type HoverPort
local M = {
  toggle = function()
    -- plugin.hover.hover()
    vim.lsp.buf.hover()
  end,
  dismiss = function()
    local winid = vim.b.lsp_floating_preview
    if winid and vim.api.nvim_win_is_valid(winid) then
      vim.api.nvim_win_close(winid, true)
      return
    end

    plugin.noice.cmd("dismiss")
  end,
}

return make_logged("adapters/hover", M)
