local M = {}

local make_logged = require("application.helpers.make_logged")
local plugins = require("infrastructure.plugins.tree")
local nvim_tree = plugins.nvim_tree
local snacks = plugins.snacks

M.open = function()
  nvim_tree.tree.open()
end

M.close = function()
  nvim_tree.tree.close()
end

M.toggle = function(opts)
  local ok, err = pcall(nvim_tree.tree.toggle, { path = opts.location })
  if not ok then
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local name = vim.api.nvim_buf_get_name(buf)
      if not name:match("NvimTree_") or vim.api.nvim_buf_is_loaded(buf) then
        goto continue
      end

      vim.api.nvim_buf_delete(buf, { force = true })

      ::continue::
    end
    nvim_tree.tree.toggle({ path = opts.location })
  end
end

return make_logged("adapters/tree", M)
