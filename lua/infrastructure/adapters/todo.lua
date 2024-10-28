local vim = vim
local M = {}

local make_logged = require("application.helpers.make_logged")
local plugins = require("infrastructure.plugins.todo")
local snacks = plugins.snacks

M.list = function()
  snacks.picker.todo_comments()
end

return make_logged("adapters/todo", M)
