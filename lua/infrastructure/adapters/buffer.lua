local make_logged = require("application.helpers.make_logged")
local plugins = require("infrastructure.plugins.plugin_registry").buffer()

local snacks = plugins.snacks

---@type BufferPort
local M = {
  add = function()
    vim.cmd("enew")
  end,

  list = function()
    snacks.picker.buffers()
  end,

  delete = function()
    snacks.bufdelete.delete()
  end,

  next = function()
    vim.cmd("bnext")
  end,

  previous = function()
    vim.cmd("bprevious")
  end,

  reopen = function()
    vim.cmd("buffer #")
  end,

  messages = function()
    vim.cmd("messages")
  end,

  close_others = function()
    snacks.bufdelete.other()
  end,
}

return make_logged("adapters/buffer", M)
