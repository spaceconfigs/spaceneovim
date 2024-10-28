local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugins = require("infrastructure.plugins.tree")
local nvim_tree = plugins.nvim_tree
local snacks = plugins.snacks

M.open = function()
  local message = {
    module = "adapters/tree",
    func = "open",
  }
  logger_use_case.debug(message)

  nvim_tree.tree.open()
end

M.close = function()
  local message = {
    module = "adapters/tree",
    func = "close",
  }
  logger_use_case.debug(message)

  nvim_tree.tree.close()
end

M.toggle = function(opts)
  local message = {
    module = "adapters/tree",
    func = "toggle",
    opts = opts,
  }
  logger_use_case.debug(message)

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

return M
