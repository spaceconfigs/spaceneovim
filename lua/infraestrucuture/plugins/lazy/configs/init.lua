local is_neovide = vim.g.neovide or false;

return {
  {
    'tristone13th/lspmark.nvim',
    opts = {},
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    }
  },
  { "natecraddock/workspaces.nvim" },
  {
    "folke/lazydev.nvim",
    opts = {},
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
    opts = {},
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
    dependencies = {
      { "folke/todo-comments.nvim", opts = {}, }
    },
    opts = {
      notifier = { enabled = true },
      quickfile = { enabled = true },
      terminal = { enabled = true, },
      input = { enabled = true, },
      image = {
        enabled = true,
        doc = {
          inline = false,
        },
      },
      picker = {
        enabled = true,
        layouts = {
          nitaicharan_lines = {
            layout = {
              box = "vertical",
              backdrop = false,
              row = -0.0000000000000000001,
              width = 0,
              height = 0.2,
              border = "none",
              title = " {title} {live} {flags}",
              title_pos = "left",
              { win = "input", height = 1, border = "none" },
              {
                box = "horizontal",
                { win = "list",    border = "none" },
                { win = "preview", title = "{preview}", width = 0.6, border = "none" },
              },
            }
          },
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
      styles = {
        terminal = {
          position = 'float',
          width = 0,
          height = 0,
        }
      }
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
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      provider = "gemini",
      gemini = {
        -- @see https://ai.google.dev/gemini-api/docs/models/gemini
        model = "gemini-2.0-flash",
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
        api_key_name = "cmd:pass ai.google.dev/token"
      },
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
    },
    build = "make", -- if you want to build from source then do make BUILD_FROM_SOURCE=true
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick",         -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua",              -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
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
        "MeanderingProgrammer/render-markdown.nvim",
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
    "saghen/blink.cmp",
    version = '*',
    dependencies = {
      { "saghen/blink.compat", opts = { enable_events = true } },
      'rafamadriz/friendly-snippets',
      'Kaiser-Yang/blink-cmp-avante',
      {
        "Exafunction/codeium.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        opts = {},
      },
    },
    opts = {
      keymap = {
        preset = 'enter',
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'avante', 'lsp', 'path', 'snippets', 'buffer', "codeium" },
        providers = {
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
          },
          codeium = {
            name = "codeium",
            module = "blink.compat.source",
            score_offset = 3,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust" }
    },
    opts_extend = { "sources.default" }
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } }, -- Optional
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
    "nitaicharan/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {}
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
    opts = {
      float_opts = {
        border = 'none',
        width = vim.o.columns,
        height = vim.o.lines,
      },
    },

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
      { "EdenEast/nightfox.nvim", lazy = false, priority = 1000 },
      -- { "folke/tokyonight.nvim" },
      -- { "iruzo/matrix-nvim" },
      -- { "catppuccin/nvim",                 name = "catppuccin" },
      -- { "scottmckendry/cyberdream.nvim" },
      -- { "Mofiqul/vscode.nvim" },
      -- { "Mofiqul/dracula.nvim" },
      -- { "nyoom-engineering/oxocarbon.nvim" },
      -- { "AlexvZyl/nordic.nvim" },
    }
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
  { "tiagovla/scope.nvim",    opts = {}, lazy = false },
  {
    "3rd/image.nvim",
    enabled = not is_neovide,
  },
  { "HakonHarnes/img-clip.nvim",   lazy = false },
  { "norcalli/nvim-colorizer.lua", options = {}, lazy = false },
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
    opts = {},
  },
  {
    'echasnovski/mini.nvim',
    lazy = false,
    init = function()
      require('mini.surround').setup({
        mappings = {
          add = 'ys',
          delete = 'ds',
          find = 'sf',
          find_left = 'sF',
          -- highlight = 'sh',
          replace = 'cs',
          -- update_n_lines = 'sn',
          suffix_last = 'l',
          suffix_next = 'n',
        }
      })

      vim.api.nvim_set_keymap('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
      vim.api.nvim_set_keymap('n', 'yss', 'ys_', { noremap = false })

      require('mini.pairs').setup()
      require('mini.ai').setup()
    end
  },
  {
    "declancm/cinnamon.nvim",
    event = "BufRead",
    opts = {},
  },
  {
    "hedyhli/outline.nvim",
    event = "BufRead",
  },
  -- {
  -- 	"tris203/precognition.nvim",
  -- 	opts = {},
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
  {
    'jellydn/hurl.nvim',
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown" },
        },
        ft = { "markdown" },
      },
    },
  }
}
