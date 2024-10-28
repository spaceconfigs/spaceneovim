-- Headless spec: window.scroll drives the NEXT window, never the current one.
--   nvim --headless -u NONE -c "luafile tests/window_scroll_next_spec.lua" -c "qa!"
package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path

package.loaded["application.usecases.logger"] =
  { debug = function() end, info = function() end, warn = function() end, error = function() end, log = function() end }
package.loaded["infrastructure.plugins.plugin_registry"] = setmetatable({}, {
  __index = function()
    return function()
      return { maximize = { toggle = function() end } }
    end
  end,
})

local adapter = require("infrastructure.adapters.window")

local failures = 0
local function check(label, cond, detail)
  print((cond and "ok   - " or "FAIL - ") .. label .. (detail and (" [" .. detail .. "]") or ""))
  if not cond then failures = failures + 1 end
end

-- A buffer long enough that half-page scrolling has somewhere to go.
local lines = {}
for i = 1, 500 do
  lines[i] = "line " .. i
end
vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

local function topline(win)
  return vim.api.nvim_win_call(win, function()
    return vim.fn.line("w0")
  end)
end

-- Two windows on the same long buffer; focus the first.
vim.cmd("silent only")
vim.cmd("vsplit")
vim.cmd("wincmd h")

local me = vim.api.nvim_get_current_win()
local other = vim.fn.win_getid(vim.fn.winnr() % vim.fn.winnr("$") + 1)
check("probe setup produced two distinct windows", me ~= other)

local other_before, me_before = topline(other), topline(me)
adapter.scroll("down")
local other_after = topline(other)
check("next window scrolled down", other_after > other_before, other_before .. " -> " .. other_after)
check("current window did not scroll", topline(me) == me_before, "w0=" .. topline(me))
check("focus stayed put", vim.api.nvim_get_current_win() == me)

adapter.scroll("up")
check("next window scrolled back up", topline(other) < other_after, other_after .. " -> " .. topline(other))

-- Visual mode must survive: the binding is mapped in visual mode too.
vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("Vjj", true, false, true), "x", false)
check("entered visual line mode", vim.api.nvim_get_mode().mode == "V", "mode=" .. vim.api.nvim_get_mode().mode)
adapter.scroll("down")
check("still in visual mode after scroll", vim.api.nvim_get_mode().mode == "V", "mode=" .. vim.api.nvim_get_mode().mode)
check("focus stayed put in visual mode", vim.api.nvim_get_current_win() == me)
vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)

-- A lone window must not scroll itself.
vim.cmd("silent only")
local solo_before = topline(vim.api.nvim_get_current_win())
adapter.scroll("down")
check("single window is a no-op", topline(vim.api.nvim_get_current_win()) == solo_before, "w0=" .. solo_before)

if failures > 0 then
  vim.cmd("cq")
end
