local ok, plugin = pcall(require, "themery")
if not ok then
  return vim.notify("Failed to load plugin `zaldih/themery.nvim`")
end

local themes = {}

local ok_nightfox = pcall(require, "themery")
if ok_nightfox then
  table.insert(themes, {
    name = "Night",
    colorscheme = "carbonfox",
  })
end


plugin.setup({
  themes = themes,
})

return plugin
