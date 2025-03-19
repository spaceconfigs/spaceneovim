local ok, plugin = pcall(require, "themery")
if not ok then
  error("Failed to load plugin `zaldih/themery.nvim`")
end

local ok_nightfox = pcall(require, "themery")

local themes = {}

if ok_nightfox then
  table.insert(themes, {
    name = "carbonfox",
    colorscheme = "carbonfox",
  })
end

plugin.setup({
  themes = themes,
})

return plugin

