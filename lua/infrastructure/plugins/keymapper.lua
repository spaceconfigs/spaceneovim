local vim = vim

local ok, which_key = pcall(require, "which-key")
if not ok then
  error("Failed to load plugin `folke/which-key.nvim`")
end

local ok_hydra, hydra = pcall(require, "hydra")
if not ok_hydra then
  error("Failed to load plugin `nvimtools/hydra.nvim`")
end

return {
  which_key = which_key,
  hydra = hydra,
}
