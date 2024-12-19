return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  { "lewis6991/gitsigns.nvim" },
  { "sindrets/diffview.nvim" },
  { "folke/snacks.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
  }
}
