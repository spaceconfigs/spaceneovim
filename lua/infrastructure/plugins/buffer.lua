local bufferline_ok = pcall(require, "bufferline")
if not bufferline_ok then
  error("Failed to load plugin `akinsho/bufferline.nvim`")
end

local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  error("Failed to load plugin `folke/snacks.nvim`")
end

return {
  snacks = snacks,
}
