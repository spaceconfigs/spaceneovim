local hurl_ok, hurl = pcall(require, "hurl")

if not hurl_ok then
  error("Failed to load plugin `jellydn/hurl.nvim`")
end

return {
  hurl = hurl,
}
