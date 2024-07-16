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

return { gitsigns = gitsigns, neogit = neogit }
