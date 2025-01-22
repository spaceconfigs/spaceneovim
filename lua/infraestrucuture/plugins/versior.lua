local ok_gitsigns, gitsigns = pcall(require, "gitsigns")
if not ok_gitsigns then
  return vim.notify("Failed to load plugin `lewis6991/gitsigns.nvim`")
end
gitsigns.setup()

local neogit_ok, neogit = pcall(require, "neogit")
if not neogit_ok then
  return vim.notify("Failed to load plugin `NeogitOrg/neogit`")
end

neogit.setup()

-- neogit.lib.popup:builder()

local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  return vim.notify("Failed to load plugin `folke/snacks.nvim`")
end

-- snacks.setup()

local octo_ok, octo = pcall(require, "octo")
if not octo_ok then
  return vim.notify("Failed to load plugin `pwntester/octo.nvim`")
end

octo.setup()

return { gitsigns = gitsigns, neogit = neogit, snacks = snacks, octo = octo }
