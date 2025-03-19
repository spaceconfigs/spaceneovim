local ok, blink_cmp = pcall(require, "blink.cmp")

if not ok then
  error("Failed to load plugin `Saghen/blink.cmp`")
end

-- print(vim.inspect(blink_cmp))

return {
  blink_cmp = blink_cmp
}
