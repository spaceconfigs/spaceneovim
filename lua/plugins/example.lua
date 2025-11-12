return {
  {
    "folke/snacks.nvim",
    optional = true,
    keys = false,
  },
  { "folke/lazy.nvim", optional = true, keys = false },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      opts = opts or {}
      opts.spec = opts.spec or {}
      vim.list_extend(opts.spec, {
        { "<leader>b", group = "Buffers" },
        { "<leader>f", group = "Files" },
        { "<leader>fy", group = "Copy" },
        { "<leader>fe", group = "Config" },
        { "<leader>w", group = "Windows" },
        { "<leader>wp", group = "Notifications" },
      })

      opts.preset = "modern"
      opts.win = {
        padding = { 3, 3 }, -- extra window padding [top/bottom, right/left]
        wo = {},
      }
      opts.layout = {
        align = "center", -- align columns center
      }

      return opts
    end,
  },
}
