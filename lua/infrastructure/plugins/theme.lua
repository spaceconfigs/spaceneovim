local ok, plugin = pcall(require, "themery")
if not ok then
  error("Failed to load plugin `zaldih/themery.nvim`")
end

local ok_nightfox = pcall(require, "nightfox")
local ok_cyberdream = pcall(require, "cyberdream")
local ok_tokyonight = pcall(require, "tokyonight")

local themes = {}

if ok_nightfox then
  table.insert(themes, {
    name = "carbonfox",
    colorscheme = "carbonfox",
  })
end

if ok_cyberdream then
  table.insert(themes, {
    name = "cyberdream",
    colorscheme = "cyberdream",
  })
end

if ok_tokyonight then
  table.insert(themes, {
    name = "tokyonight",
    colorscheme = "tokyonight",
  })
  table.insert(themes, {
    name = "tokyonight-night",
    colorscheme = "tokyonight-night",
  })
end

plugin.setup({
  themes = themes,
})

return plugin
