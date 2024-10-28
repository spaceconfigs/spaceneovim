local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.plugin_registry").window()
local maximize = plugin.maximize

local go_commands = { left = "h", right = "l", up = "k", down = "j" }

---@type WindowPort
local M = {
  toggle = function()
    maximize.toggle()
  end,

  go = function(direction)
    vim.cmd("wincmd " .. go_commands[direction])
  end,

  move = function(direction)
    vim.cmd("WinShift " .. direction)
  end,

  move_far = function(direction)
    vim.cmd("WinShift far_" .. direction)
  end,

  go_to = function(number)
    vim.cmd("wincmd " .. number .. " w")
  end,

  close = function()
    vim.cmd("quit")
  end,

  split = function(opts)
    local cmd = opts.type
    if opts.previous then
      cmd = cmd .. " | wincmd p"
    end

    vim.cmd(cmd)
  end,

  dedicate = function()
    vim.cmd("PinBuffer")
  end,

  resize = function(opts)
    local axis = opts.axis
    local delta = opts.delta
    local getter = axis == "height" and vim.api.nvim_win_get_height or vim.api.nvim_win_get_width
    local setter = axis == "height" and vim.api.nvim_win_set_height or vim.api.nvim_win_set_width

    setter(0, getter(0) + delta)
  end,

  balance = function()
    vim.cmd("wincmd =")
  end,

  layout = function(opts)
    local count = opts.count
    local cur_win = vim.api.nvim_get_current_win()
    local cur_buf = vim.api.nvim_win_get_buf(cur_win)

    local bufs = { cur_buf }
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if win ~= cur_win and vim.api.nvim_win_get_config(win).relative == "" then
        table.insert(bufs, vim.api.nvim_win_get_buf(win))
      end
    end

    if #bufs < count then
      local infos = vim.fn.getbufinfo({ buflisted = 1 })
      table.sort(infos, function(a, b)
        return a.lastused > b.lastused
      end)
      local inlist = {}
      for _, buf in ipairs(bufs) do
        inlist[buf] = true
      end
      for _, info in ipairs(infos) do
        if #bufs >= count then
          break
        end
        if not inlist[info.bufnr] then
          table.insert(bufs, info.bufnr)
          inlist[info.bufnr] = true
        end
      end
      while #bufs < count do
        table.insert(bufs, cur_buf)
      end
    end

    while #bufs > count do
      table.remove(bufs)
    end

    vim.api.nvim_set_current_win(cur_win)
    vim.cmd("silent only")
    local base = vim.api.nvim_get_current_win()

    local slots
    if count == 1 then
      slots = { base }
    elseif count == 2 then
      local w2 = vim.api.nvim_open_win(cur_buf, false, { win = base, split = "right" })
      slots = { base, w2 }
    elseif count == 3 then
      local w2 = vim.api.nvim_open_win(cur_buf, false, { win = base, split = "right" })
      local w3 = vim.api.nvim_open_win(cur_buf, false, { win = w2, split = "right" })
      slots = { base, w2, w3 }
    else
      local col2 = vim.api.nvim_open_win(cur_buf, false, { win = base, split = "right" })
      local col1_bottom = vim.api.nvim_open_win(cur_buf, false, { win = base, split = "below" })
      local col2_bottom = vim.api.nvim_open_win(cur_buf, false, { win = col2, split = "below" })
      slots = { base, col1_bottom, col2, col2_bottom }
    end

    for i, win in ipairs(slots) do
      vim.api.nvim_win_set_buf(win, bufs[i])
    end

    vim.cmd("wincmd =")
    vim.api.nvim_set_current_win(slots[1])
  end,
}

return make_logged("adapters/window", M)
