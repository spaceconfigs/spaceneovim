package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path

package.loaded["application.usecases.logger"] =
{ debug = function() end, info = function() end, warn = function() end, error = function() end, log = function() end }
package.loaded["infrastructure.plugins.plugin_registry"] = setmetatable({}, {
  __index = function() return function() return { maximize = { toggle = function() end } } end end,
})

local adapter = require("infrastructure.adapters.window")

local failures = 0
local function check(label, cond)
  if cond then
    print("ok   - " .. label)
  else
    failures = failures + 1
    print("FAIL - " .. label)
  end
end

-- Compact string form of the current window layout tree.
local function shape(node)
  node = node or vim.fn.winlayout(0)
  if node[1] == "leaf" then return "L" end
  local parts = {}
  for _, child in ipairs(node[2]) do parts[#parts + 1] = shape(child) end
  return node[1] .. "(" .. table.concat(parts, ",") .. ")"
end

local expected = {
  [1] = "L",
  [2] = "row(L,L)",
  [3] = "row(L,L,L)",
  [4] = "row(col(L,L),col(L,L))",
}

for _, n in ipairs({ 1, 2, 3, 4 }) do
  vim.cmd("silent only")
  adapter.layout({ count = n })
  check(("count=%d window count"):format(n), #vim.api.nvim_tabpage_list_wins(0) == n)
  check(("count=%d shape"):format(n), shape() == expected[n])
end

vim.cmd("silent only")
local a = vim.api.nvim_create_buf(true, false)
local b = vim.api.nvim_create_buf(true, false)
vim.api.nvim_set_current_buf(a)
vim.api.nvim_open_win(b, false, { win = 0, split = "right" })
vim.api.nvim_set_current_buf(a)
adapter.layout({ count = 2 })
check("current buffer preserved as slot 1", vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_list_wins(0)[1]) == a)

vim.cmd("silent only")
local buf1 = vim.api.nvim_create_buf(true, false)
local buf2 = vim.api.nvim_create_buf(true, false)
local buf3 = vim.api.nvim_create_buf(true, false)
vim.api.nvim_set_current_buf(buf1)
vim.api.nvim_open_win(buf2, false, { win = 0, split = "right" })
vim.api.nvim_open_win(buf3, false, { win = 0, split = "right" })
vim.api.nvim_set_current_buf(buf1)
adapter.layout({ count = 3 })
do
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local slot_bufs = {}
  for i, w in ipairs(wins) do
    slot_bufs[i] = vim.api.nvim_win_get_buf(w)
  end
  local expected_set = { [buf1] = true, [buf2] = true, [buf3] = true }
  local actual_set = { [slot_bufs[1]] = true, [slot_bufs[2]] = true, [slot_bufs[3]] = true }
  local same_set = true
  for b in pairs(expected_set) do
    if not actual_set[b] then same_set = false end
  end
  for b in pairs(actual_set) do
    if not expected_set[b] then same_set = false end
  end
  check("3-window regroup: slot 1 is current buffer", slot_bufs[1] == buf1)
  check("3-window regroup: slot set matches created buffers", same_set)
end

vim.cmd("silent only")
local buf_a = vim.api.nvim_create_buf(true, false)
vim.api.nvim_set_current_buf(buf_a)
local normal_win = vim.api.nvim_get_current_win()
local fbuf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_open_win(fbuf, false, { relative = "editor", width = 10, height = 3, row = 1, col = 1 })
vim.api.nvim_set_current_buf(buf_a)
vim.api.nvim_set_current_win(normal_win)
adapter.layout({ count = 2 })
do
  local wins = vim.api.nvim_tabpage_list_wins(0)
  check("float exclusion: window count", #wins == 2)
  local float_leaked = false
  for _, w in ipairs(wins) do
    if vim.api.nvim_win_get_buf(w) == fbuf then float_leaked = true end
  end
  check("float exclusion: float buffer not pinned into a slot", not float_leaked)
end

if failures > 0 then vim.cmd("cq") end
