local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.registry").composer()
local Popup = plugin.Popup
local event = plugin.event

---@type ComposerPort
local M = {
  open = function(opts)
    local min_height = 1
    local max_height = 20
    local width = math.min(80, math.floor(vim.o.columns * 0.6))

    local padding = { top = 1, right = 2, bottom = 1, left = 2 }

    local popup = Popup({
      enter = true,
      position = "50%",
      relative = "editor",
      size = { width = width, height = min_height },
      border = {
        style = "rounded",
        padding = padding,
        text = { top = opts.title, top_align = "center" },
      },
      buf_options = { filetype = opts.filetype or "markdown" },
      win_options = { wrap = true },
    })

    popup:mount()

    local buf = popup.bufnr

    local resize = function()
      if not vim.api.nvim_win_is_valid(popup.winid) then
        return
      end

      local rows = 0
      for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
        rows = rows + math.max(1, math.ceil(vim.fn.strdisplaywidth(line) / width))
      end

      local height = math.max(min_height, math.min(max_height, rows))
      popup:update_layout({
        relative = "editor",
        position = "50%",
        size = { width = width, height = height },
      })
    end

    popup:on({ event.TextChanged, event.TextChangedI }, resize)

    local closed = false
    local close  = function()
      if closed then
        return
      end

      closed = true
      popup:unmount()
    end

    local submit = function()
      local input = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
      close()

      if input == "" then return end
      opts.on_submit(input)
    end

    popup:map("n", "<CR>", submit, { nowait = true })
    popup:map("n", "<Esc>", close, { nowait = true })
    popup:map("n", "q", close, { nowait = true })

    popup:on(event.BufLeave, close)

    vim.cmd("startinsert")
  end,
}

return make_logged("adapters/composer", M)
