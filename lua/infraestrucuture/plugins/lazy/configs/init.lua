local is_neovide = vim.g.neovide or false;

return {
  { "natecraddock/workspaces.nvim" },
  {
    "folke/lazydev.nvim",
    config = true,
    ft = "lua",
  },
  {
    "mfussenegger/nvim-jdtls",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "folke/noice.nvim",
    event = "BufRead",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      messages = {
        enabled = true,
      },
      views = {
        cmdline_popup = {
          border = {
            style = "single",
            padding = { 2, 2 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "windwp/nvim-ts-autotag",
    config = true,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    'folke/snacks.nvim',
    opts = {
      picker = {
        layouts = {
          nitaicharan = {
            layout = {
              box = "horizontal",
              backdrop = false,
              width = 0,
              height = 0,
              {
                box = "vertical",
                { win = "preview", height = 0.8,        title = "{preview:Preview}", title_pos = "center", },
                { win = "input",   height = 1,          border = "none",             title = "{title} {live} {flags}", title_pos = "center" },
                { win = "list",    title = " Results ", title_pos = "center",        border = "none" },
              },
            },
          },
        },
      },
    }
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "cbochs/grapple.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "otavioschwanck/arrow.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
  },
  {
    "tomasky/bookmarks.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
  },
  { "BartSte/nvim-project-marks" },
  { "chentoast/marks.nvim" },
  { "hedyhli/outline.nvim" },
  { "famiu/bufdelete.nvim" },
  {
    "akinsho/bufferline.nvim",
    branch = "main",
  },
  { "nvim-lua/plenary.nvim" },
  { "David-Kunz/gen.nvim" },
  {
    "yetone/avante.nvim",
    lazy = false,
    version = false,
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-nvim-lsp",
      {
        "Exafunction/codeium.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        config = true,
      },
    },
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    }
  },
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui",      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { "mfussenegger/nvim-lint" },
  { "folke/trouble.nvim" },
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { "stevearc/conform.nvim" },
  { "lewis6991/hover.nvim" },
  { "folke/flash.nvim", },
  { "smoka7/hop.nvim", },
  {
    "folke/which-key.nvim",
    dependencies = { "echasnovski/mini.nvim" }
  },
  { "mfussenegger/nvim-lint" },
  { "Tastyep/structlog.nvim", },
  {
    "nvim-orgmode/orgmode",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
    },
  },
  { "rcarriga/nvim-notify" },
  { "dhruvasagar/vim-table-mode", },
  {
    "epwalsh/pomo.nvim",
    version = "*",
    dependencies = {
      "rcarriga/nvim-notify",
    },
  },
  {
    "wet-sandwich/hyper.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
  },
  { "BlackLight/nvim-http", },
  {
    "smoka7/multicursors.nvim",
    dependencies = {
      'smoka7/hydra.nvim',
    },
    opts = {},
  },
  {
    "Shatur/neovim-session-manager",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  { "nvim-lualine/lualine.nvim", },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
      "rcasia/neotest-java",
    },
  },
  {
    "zaldih/themery.nvim",
    dependencies = {
      { "folke/tokyonight.nvim" },
      { "iruzo/matrix-nvim" },
      { "catppuccin/nvim",        name = "catppuccin" },
      { "EdenEast/nightfox.nvim", lazy = false,       priority = 1000 },
    }
  },
  {
    "folke/todo-comments.nvim",
    opts = {},
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "nvim-tree/nvim-tree.lua", },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  { "lewis6991/gitsigns.nvim" },
  { "sindrets/diffview.nvim" },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'folke/snacks.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },
  { "sindrets/winshift.nvim" },
  { "declancm/maximize.nvim" },
  { "stevearc/stickybuf.nvim" },
  { "pocco81/true-zen.nvim" },
  { "folke/twilight.nvim" },
  { "folke/zen-mode.nvim" },
  { "ThePrimeagen/vim-be-good", lazy = false },
  { "tiagovla/scope.nvim",      opts = {},   lazy = false },
  {
    "3rd/image.nvim",
    enabled = not is_neovide,
  },
  { "HakonHarnes/img-clip.nvim",   lazy = false },
  { "norcalli/nvim-colorizer.lua", options = {}, lazy = false },
  { "stevearc/dressing.nvim",      options = {}, lazy = false },
  { "xiyaowong/transparent.nvim",  options = {}, lazy = false },
  {
    "jinh0/eyeliner.nvim",
    lazy = false,
    opts = {
      highlight_on_key = true,
      dim = true,
    },
  },
  {
    "LunarVim/bigfile.nvim",
    event = "BufRead",
    config = true,
  },
  {
    "kylechui/nvim-surround",
    event = "BufRead",
    config = true,
  },
  {
    "declancm/cinnamon.nvim",
    event = "BufRead",
    config = true,
  },
  {
    "tzachar/local-highlight.nvim",
    event = "BufRead",
    opts = {},
    lazy = false,
  },
  -- {
  -- 	"goolord/alpha-nvim",
  -- 	dependencies = { "nvim-tree/nvim-web-devicons" },
  -- 	lazy = false,
  -- 	config = function()
  -- 		require("alpha").setup(require("alpha.themes.startify").config)
  -- 	end,
  -- },
  {
    "hedyhli/outline.nvim",
    event = "BufRead",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- {
  -- 	"tris203/precognition.nvim",
  -- 	config = true,
  -- 	event = "BufRead",
  -- },
  {
    "m4xshen/hardtime.nvim",
    event = "BufRead",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disabled_keys = {
        ["<Up>"] = { "" },
        ["<Down>"] = { "" },
        ["<Left>"] = { "" },
        ["<Right>"] = { "" },
      },
    },
  },
}
