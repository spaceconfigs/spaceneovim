local ok_gitsigns, gitsigns = pcall(require, "gitsigns")
if not ok_gitsigns then
  error("Failed to load plugin `lewis6991/gitsigns.nvim`")
end

local neogit_ok, neogit = pcall(require, "neogit")
if not neogit_ok then
  error("Failed to load plugin `NeogitOrg/neogit`")
end

local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  error("Failed to load plugin `folke/snacks.nvim`")
end

local octo_ok, octo = pcall(require, "octo")
if not octo_ok then
  error("Failed to load plugin `pwntester/octo.nvim`")
end

local codediff_ok, codediff = pcall(require, "codediff")
if not codediff_ok then
  error("Failed to load plugin `esmuellert/codediff.nvim`")
end

local tardis_ok, tardis = pcall(require, "tardis-nvim")
if not tardis_ok then
  error("Failed to load plugin `FredeHoey/tardis.nvim`")
end

return {
  gitsigns = gitsigns,
  neogit = neogit,
  snacks = snacks,
  octo = octo,
  tardis = tardis,
  codediff = codediff,
}
