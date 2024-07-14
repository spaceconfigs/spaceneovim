local ok, plugin = pcall(require, "themery")

local themes = {}

if not ok then
  return vim.notify("Failed to load plugin `zaldih/themery.nvim`")
end


local ok_nightfox = pcall(require, "themery")

if ok_nightfox then
  table.insert(themes, {
    name = "Night",
    colorscheme = "carbonfox",
    themeConfigFile = "~/.config/nvim/lua/infraestrucuture/plugins/theme.lua",
  })
end


plugin.setup({
  themes = themes,
})

return plugin

-- Themery block
  -- This block will be replaced by Themery.
-- end themery block
