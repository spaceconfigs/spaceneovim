local ok, plugin = pcall(require, "devdocs")
if not ok then
  error("Failed to load plugin `nitaicharan/devdocs.nvim`")
end

return plugin

-- local ok, devdocs = pcall(require, "devdocs")
-- if not ok then
--   error("Failed to load plugin `maskudo/devdocs`")
-- end
--
-- local snacks_ok, snacks = pcall(require, "snacks")
-- if not snacks_ok then
--   error("Failed to load plugin `folke/snacks.nvim`")
-- end
--
-- return {
--   snacks = snacks,
--   devdocs = devdocs
-- }
