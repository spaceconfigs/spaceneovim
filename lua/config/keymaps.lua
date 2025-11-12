-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
vim.keymap.del("n", "<leader>fT")
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>|")
vim.keymap.del("n", "[b")
vim.keymap.del("n", "]b")
vim.keymap.del("n", "<leader>`")

-- small helpers
local function project_root()
  local ok, root = pcall(function()
    return LazyVim and LazyVim.root and LazyVim.root.get and LazyVim.root.get() or nil
  end)
  return (ok and root and root ~= "") and root or (vim.uv or vim.loop).cwd()
end

local function rel_to_root(path)
  local root = project_root()
  if vim.fs and vim.fs.relpath then
    return vim.fs.relpath(path, root) or path
  else
    return vim.fn.fnamemodify(vim.fn.relpath(path, root), ":.")
  end
end

-- safe Snacks accessor
local function S()
  local ok, snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("Snacks.nvim is not available", vim.log.levels.WARN)
    return nil
  end
  return snacks
end

------------------------------------------
--- Mix binds
------------------------------------------
map("n", "<leader>'", function()
  Snacks.terminal()
end, { desc = "Terminal (cwd)" })

------------------------------------------
--- Buffer binds
------------------------------------------
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<leader>b<tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", function()
  Snacks.picker.buffers()
end, { desc = "List" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete" })
map("n", "<leader>b<C-d>", function()
  Snacks.bufdelete.other()
end, { desc = "Delete others" })

------------------------------------------
--- File binds
------------------------------------------
map("n", "<leader>fs", function()
  if vim.api.nvim_buf_get_name(0) == "" then
    return vim.cmd("confirm saveas")
  end
  vim.cmd("silent! update")
end, { desc = "Save" })

map("n", "<leader>fS", function()
  local infos = vim.fn.getbufinfo({ bufmodified = 1 })
  local n = 0
  for _, bi in ipairs(infos) do
    if bi.name and bi.name ~= "" then
      n = n + 1
    end
  end
  if n == 0 then
    return vim.notify("No modified files to save.", vim.log.levels.INFO)
  end
  local ok, err = pcall(vim.cmd, "silent! wall")
  if ok then
    vim.notify(("Saved %d file%s."):format(n, n == 1 and "" or "s"))
  else
    vim.notify("Save-all failed: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Save All" })

map("n", "<leader>fD", function()
  local buf = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then
    return vim.notify("No file associated with this buffer.", vim.log.levels.WARN)
  end

  vim.ui.input({ prompt = ("Delete file?\n%s\nType 'yes' to confirm: "):format(file) }, function(input)
    if input ~= "yes" then
      return
    end
    local ok
    if vim.fn.executable("trash") == 1 then
      vim.fn.system({ "trash", file })
      ok = (vim.v.shell_error == 0)
    else
      ok = vim.fn.delete(file) == 0
    end
    if ok then
      if #vim.fn.getbufinfo({ buflisted = 1 }) <= 1 then
        pcall(vim.cmd, "enew")
      end
      pcall(vim.cmd, "bdelete! " .. buf)
      vim.notify("Deleted: " .. file)
    else
      vim.notify("Failed to delete: " .. file, vim.log.levels.ERROR)
    end
  end)
end, { desc = "Delete" })

map("n", "<leader>fed", LazyVim.pick and LazyVim.pick.config_files() or function()
  vim.notify("LazyVim.pick.config_files() not available", vim.log.levels.WARN)
end, { desc = "Edit Config" })

map("n", "<leader>feU", function()
  require("lazy").update({ show = true })
end, { desc = "Update Packages" })

map("n", "<leader>fy", "<Nop>", { desc = "Copy" })

map("n", "<leader>fyd", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return vim.notify("No file for this buffer.", vim.log.levels.WARN)
  end
  local dir = vim.fn.fnamemodify(file, ":h")
  vim.fn.setreg("+", dir)
  vim.fn.setreg("*", dir)
  vim.notify("Copied directory:\n" .. dir)
end, { desc = "Copy [d]irectory" })

map("n", "<leader>fyD", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return vim.notify("No file for this buffer.", vim.log.levels.WARN)
  end
  local proj_dir = vim.fn.fnamemodify(vim.fn.relpath(vim.fn.fnamemodify(file, ":h"), project_root()), ":.")
  vim.fn.setreg("+", proj_dir)
  vim.fn.setreg("*", proj_dir)
  vim.notify("Copied project directory:\n" .. proj_dir)
end, { desc = "Project Directory" })

map("n", "<leader>fyl", function()
  local line = vim.api.nvim_get_current_line()
  vim.fn.setreg("+", line)
  vim.fn.setreg("*", line)
end, { desc = "Line" })

map("n", "<leader>fyL", function()
  local file = vim.api.nvim_buf_get_name(0)
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  if file == "" then
    local only = (":" .. lnum)
    vim.fn.setreg("+", only)
    vim.fn.setreg("*", only)
    return vim.notify("Copied project [L]ine (no file): " .. only)
  end
  local text = rel_to_root(file) .. ":" .. lnum
  vim.fn.setreg("+", text)
  vim.fn.setreg("*", text)
  vim.notify("Copied Project [L]ine:\n" .. text)
end, { desc = "Copy Project [L]ine" })

map("n", "<leader>fyn", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return vim.notify("No file for this buffer.", vim.log.levels.WARN)
  end
  local name = vim.fn.fnamemodify(file, ":t")
  vim.fn.setreg("+", name)
  vim.fn.setreg("*", name)
  vim.notify("Copied file [n]ame: " .. name)
end, { desc = "File name" })

map("n", "<leader>fyN", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return vim.notify("No file for this buffer.", vim.log.levels.WARN)
  end
  local stem = vim.fn.fnamemodify(file, ":t:r")
  vim.fn.setreg("+", stem)
  vim.fn.setreg("*", stem)
  vim.notify("Copied file [N]ame (no ext): " .. stem)
end, { desc = "File name without extension" })

map("n", "<leader>fyy", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return vim.notify("No file for this buffer.", vim.log.levels.WARN)
  end
  local abs = vim.fn.fnamemodify(file, ":p")
  vim.fn.setreg("+", abs)
  vim.fn.setreg("*", abs)
  vim.notify("Copied Path: " .. abs)
end, { desc = "Path" })

map("n", "<leader>fyY", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return vim.notify("No file for this buffer.", vim.log.levels.WARN)
  end
  local rel = rel_to_root(file)
  vim.fn.setreg("+", rel)
  vim.fn.setreg("*", rel)
  vim.notify("Copied Project path: " .. rel)
end, { desc = "Project path" })

map("n", "<leader>ff", function()
  local snacks = S()
  if not snacks then
    return
  end
  local name = vim.api.nvim_buf_get_name(0)
  local cwd = (name ~= "" and vim.fn.fnamemodify(name, ":h")) or (vim.uv or vim.loop).cwd()
  snacks.picker.files({ cwd = cwd })
end, { desc = "Find" })

map("n", "<leader>fr", function()
  local snacks = S()
  if not snacks then
    return
  end
  snacks.picker.recent()
end, { desc = "Recents" })

map("n", "<leader>fR", function()
  local snacks = S()
  if not snacks then
    return
  end
  snacks.rename.rename_file()
end, { desc = "Rename" })

map("n", "<leader>ft", function()
  local snacks = S()
  if not snacks then
    return
  end
  snacks.explorer({ follow_file = true })
end, { desc = "Tree" })

------------------------------------------
--- Window binds
------------------------------------------
map("n", "<leader>wpm", function()
  local snacks = S()
  if not snacks then
    return
  end
  snacks.picker.notifications()
end, { desc = "Show message history" })

map("n", "<leader>wm", function()
  if vim.t._maximized then
    vim.t._maximized = false
    vim.cmd("wincmd =")
  else
    vim.t._maximized = true
    vim.cmd("wincmd _ | wincmd |")
    vim.notify("Window: maximized")
  end
end, { desc = "Maximize window (toggle)" })

map("n", "<leader>wS", "<C-W>s", { desc = "Split Window Below" })
map("n", "<leader>wV", "<C-W>v", { desc = "Split Window Right" })
map("n", "<leader>ws", function()
  local cur = vim.api.nvim_get_current_win()
  vim.cmd("belowright split")
  vim.fn.win_gotoid(cur)
end, { desc = "Split Below (stay)" })
map("n", "<leader>wv", function()
  local cur = vim.api.nvim_get_current_win()
  vim.cmd("belowright vsplit")
  vim.fn.win_gotoid(cur)
end, { desc = "Split Right (stay)" })

map("n", "<leader>wj", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<leader>wk", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<leader>wl", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<leader>wh", "<C-w>h", { desc = "Go to Left Window" })
