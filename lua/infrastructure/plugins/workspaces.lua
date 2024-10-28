local ok_workspaces, workspaces = pcall(require, "workspaces")
if not ok_workspaces then
  error("Failed to load plugin `natecraddock/workspaces.nvim`")
end

local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  error("Failed to load plugin `folke/snacks.nvim`")
end

return { workspaces = workspaces, snacks = snacks }
