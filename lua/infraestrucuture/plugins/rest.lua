local ok_hyper, hyper = pcall(require, "hyper")
if not ok_hyper then
	return vim.notify("Failed to load plugin `natecraddock/workspaces.nvim`")
end
hyper.setup()

local ok_rest_nvim, rest_nvim = pcall(require, "rest-nvim")
if not ok_rest_nvim then
	return vim.notify("Failed to load plugin `natecraddock/workspaces.nvim`")
end

local ok_telescope, telescope = pcall(require, "telescope")
if not ok_telescope then
	return vim.notify("Failed to require package `telescope`")
end

telescope.load_extension("rest")

rest_nvim.setup()

return rest_nvim, hyper
