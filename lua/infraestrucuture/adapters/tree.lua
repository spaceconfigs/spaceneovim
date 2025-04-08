local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugins = require("infraestrucuture.plugins.tree")
local snacks = plugins.snacks

M.open = function()
  local message = {
    module = "adapters/todo",
    func = "open",
  }
  logger_use_manage.debug(message)

  snacks.open()
end

M.close = function()
  local message = {
    module = "adapters/todo",
    func = "close",
  }
  logger_use_manage.debug(message)

  snacks.close()
end

M.toggle = function(opts)
  local message = {
    module = "adapters/todo",
    func = "toggle",
    opts = opts,
  }
  logger_use_manage.debug(message)

  snacks.explorer({
    layout = { auto_hide = { "input" } },
    win = {
      list = {
        keys = {
          -- ["<BS>"] = "explorer_up",
          ["l"] = "confirm",
          ["h"] = "",               -- close directory
          ["H"] = "explorer_close", -- close directory
          ["a"] = "explorer_add",
          ["c"] = "explorer_copy",
          ["d"] = "explorer_del",
          ["R"] = "explorer_rename",
          ["m"] = "explorer_move",
          -- ["o"] = "explorer_open", -- open with system application
          -- ["P"] = "toggle_preview",
          ["y"] = { "explorer_yank", mode = { "n", "x" } },
          ["p"] = "explorer_paste",
          ["r"] = "explorer_update",
          -- ["<c-c>"] = "tcd",
          -- ["<leader>/"] = "picker_grep",
          -- ["<c-t>"] = "terminal",
          -- ["."] = "explorer_focus",
          -- ["I"] = "toggle_ignored",
          -- ["H"] = "toggle_hidden",
          -- ["]g"] = "explorer_git_next",
          -- ["[g"] = "explorer_git_prev",
          -- ["]d"] = "explorer_diagnostic_next",
          -- ["Z"] = "explorer_close_all",
          ["Z"] = "",
          -- ["[d"] = "explorer_diagnostic_prev",
          -- ["]w"] = "explorer_warn_next",
          -- ["[w"] = "explorer_warn_prev",
          -- ["]e"] = "explorer_error_next",
          -- ["[e"] = "explorer_error_prev",
        },
      },
    },
  })
end

return M
