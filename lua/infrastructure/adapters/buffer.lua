local M = {}

local make_logged = require("application.helpers.make_logged")
local plugins = require("infrastructure.plugins.buffer")

local snacks = plugins.snacks

M.list = function()
  snacks.picker.buffers()
end

M.delete = function()
  snacks.bufdelete.delete()
end

M.next = function()
  vim.cmd("bnext")
end

M.previous = function()
  vim.cmd("bprevious")
end

M.reopen = function()
  vim.cmd("buffer #")
end

M.messages = function()
  vim.cmd("messages")
end

M.close_others = function()
  snacks.bufdelete.other()
end

return make_logged("adapters/buffer", M)
