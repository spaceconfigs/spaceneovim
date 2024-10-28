local hurl_ok, hurl = pcall(require, "hurl")
local kulala_ok, kulala = pcall(require, "kulala")

if not kulala_ok then
  error("Failed to load plugin `mistweaverco/kulala.nvim`")
end

if not hurl_ok then
  error("Failed to load plugin `jellydn/hurl.nvim`")
end

return {
  hurl = hurl,
  kulala = kulala,
}
