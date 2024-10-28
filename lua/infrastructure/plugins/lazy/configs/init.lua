return {
  {
    "tristone13th/lspmark.nvim",
    opts = {},
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
  },
  {
    "natecraddock/workspaces.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {},
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim",          words = { "Lazy" } },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = function()
          vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none" })
          return {
            multiline_threshold = 1,
          }
        end,
      },
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
      "dlvandenberg/tree-sitter-angular",
    },
    config = function()
      require("nvim-treesitter").install({
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "html",
        "javascript",
        "typescript",
        "tsx",
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "BufRead",
    -- opts = {
    --   presets = {
    --     lsp_doc_border = false,
    --   },
    --   cmdline = {
    --     format = {
    --       cmdline = { title = "" },
    --     },
    --   },
    --   routes = {
    --     {
    --       filter = {
    --         event = "msg_show",
    --         kind = "",
    --         find = "written",
    --       },
    --       opts = { skip = true },
    --     },
    --   },
    --   messages = {
    --     enabled = true,
    --   },
    --   views = {
    --     hover = {
    --       border = {
    --         style = "rounded",
    --         padding = { 0, 0 },
    --       },
    --     },
    --     cmdline_popup = {
    --       border = {
    --         style = "single",
    --         padding = { 2, 2 },
    --       },
    --       win_options = {
    --         winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    --       },
    --     },
    --   },
    -- },
    opts = {
      routes = {
        {
          view = 'notify',
          filter = {
            event = 'msg_showmode',
            find = 'recording',
          },
        },
      },
      cmdline = {
        format = {
          cmdline = { title = "" },
        },
      },
      messages = {
        enabled = true,
        view = 'notify',
        view_error = 'notify',
        view_warn = 'notify',
      },
      notify = {
        enabled = true,
      },
      views = {
        notify = {
          replace = true,
        },
        mini = {
          border = {
            style = 'rounded',
          },
          win_options = {
            winblend = 20,
            winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
          },
        },
        cmdline_popup = {
          position = {
            row = '50%',
            col = '50%',
          },
          size = {
            width = 60,
            height = 'auto',
          },
          border = {
            style = 'rounded',
            padding = { 2, 2 },
          },
          win_options = {
            winblend = 20,
            winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
          },
        },
      },
      lsp = {
        progress = {
          enabled = true,
          format = 'lsp_progress',
          format_done = 'lsp_progress_done',
          view = 'notify',
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  { "windwp/nvim-ts-autotag" },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
      "HakonHarnes/img-clip.nvim",
    },
    opts = {
      win_options = {
        conceallevel = {
          default = vim.api.nvim_get_option_value("conceallevel", {}),
          rendered = 3,
        },
        concealcursor = {
          default = vim.api.nvim_get_option_value("concealcursor", {}),
          rendered = "",
        },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "akinsho/bufferline.nvim",
    branch = "main",
    opts = {
      options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      { "folke/todo-comments.nvim" },
    },
    opts = {
      notifier = {
        enabled = true,
        width = { min = 40, max = 0.6 },
        wo = { wrap = true },
      },
      quickfile = { enabled = true },
      terminal = { enabled = true },
      input = { enabled = true },
      bigfile = { enabled = true },
      scroll = { enabled = true },
      image = {
        enabled = true,
        doc = {
          inline = false,
        },
      },
      picker = {
        enabled = true,
        layout = "nitaicharan",
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
            },
          },
          nitaicharan = {
            layout = {
              box = "horizontal",
              backdrop = false,
              width = 0,
              height = 0,
              {
                box = "vertical",
                {
                  win = "preview",
                  height = 0.8,
                  title_pos = "center",
                },
                {
                  win = "input",
                  height = 1,
                  border = "none",
                  title_pos = "center",
                },
                { win = "list", title_pos = "center", border = "none" },
              },
            },
          },
        },
        sources = {
          commands = {
            win = {
              input = {
                keys = {
                  ["<Right>"] = { "confirm", mode = { "i" } },
                },
              },
            },
          },
          explorer = {
            layout = {
              layout = {
                box = "vertical",
                backdrop = true,
                width = 0.8,
                height = 0.8,
                { win = "list", border = "rounded" },
              },
            },
          },
        },
      },
      styles = {
        terminal = {
          position = "float",
          border = "rounded",
          width = 0.9,
          height = 0.9,
        },
      },
    },
  },

  { "hedyhli/outline.nvim",  opts = {} },
  {
    "folke/sidekick.nvim",
    opts = {
      nes = { enabled = false },
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  },

  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      { "saghen/blink.compat", opts = { enable_events = true } },
      "rafamadriz/friendly-snippets",
      {
        "Exafunction/codeium.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        opts = {},
      },
    },
    opts = {
      completion = {
        ghost_text = {
          enabled = true,
          show_with_menu = false,
        },
        menu = {
          auto_show = false,
          winblend = 70,
        },
        documentation = {
          window = {
            winblend = 70,
          },
        },
      },
      signature = {
        window = {
          winblend = 70,
        },
      },
      keymap = {
        ["<CR>"] = { "accept", "fallback" },
        ["<Right>"] = { "accept", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer", "codeium" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority
            score_offset = 100,
          },
          codeium = {
            name = "codeium",
            module = "blink.compat.source",
            score_offset = 3,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust" },
      cmdline = {
        keymap = {
          ["<up>"] = { "select_prev", "fallback" },
          ["<down>"] = { "select_next", "fallback" },
          ["<right>"] = { "accept", "fallback" },
          ["<left>"] = { "fallback" },
          ["<cr>"] = { "fallback" },
          ["<esc>"] = {
            "hide",
            "cancel",
            function()
              if vim.fn.getcmdtype() ~= "" then
                vim.api.nvim_feedkeys(
                  vim.api.nvim_replace_termcodes("<C-c>", true, true, true),
                  "n",
                  true
                )
                return
              end
            end,
          },
        },
        completion = { menu = { auto_show = true } },
      },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
      require("blink.cmp").setup(opts)

      -- The menu's winblend makes the whole window transparent, including the
      -- selected item. A per-highlight blend = 0 overrides the window's
      -- winblend, keeping the current line solid while the rest stays clear.
      local function solid_selection()
        local sel = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })
        sel.blend = 0
        vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", sel)
      end

      solid_selection()
      -- blink re-links BlinkCmpMenuSelection to PmenuSel on every colorscheme change.
      vim.api.nvim_create_autocmd("ColorScheme", { callback = solid_selection })
    end,
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod" },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  { "neovim/nvim-lspconfig",     lazy = false },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
    },
    opts = {
      ensure_installed = {
        "lua_ls",
      },
      servers = {

        vtsls = {
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          settings = {
            typescript = {
              tsserver = { useSeparateSyntaxServer = true },
              suggest = { completeFunctionCalls = true },
              preferences = { importModuleSpecifier = "non-relative" },
            },
            vtsls = { enableMoveToFileCodeAction = true },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        }
      },
    },
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
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

  { "folke/trouble.nvim",    opts = {} },

  {
    "nitaicharan/devdocs.nvim",
    dir = "/home/dan/Projects/devdocs.nvim",
    dev = true,
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {},
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["*"] = { "codespell" },
        javascript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        typescript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        css = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        html = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        htmlangular = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        json = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        yaml = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        markdown = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        graphql = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
        python = { "isort", "black", stop_after_first = true },
        java = { "google-java-format" },
      },
    },
  },

  { "lewis6991/hover.nvim" },

  { "folke/flash.nvim",    opts = {} },

  { "smoka7/hop.nvim",     opts = {} },

  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
      win = {
        padding = { 3, 3 }, -- extra window padding [top/bottom, right/left]
      },
      layout = {
        align = "center", -- align columns center
      },
    },
    dependencies = { "echasnovski/mini.nvim" },
  },

  { "Tastyep/structlog.nvim" },

  {
    "nvim-orgmode/orgmode",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    opts = {},
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      ui = { enable = false },
      workspaces = {
        {
          name = "Personal",
          path = vim.fn.expand("~") .. "/Notes",
        },
      },
    },
  },

  { "dhruvasagar/vim-table-mode" },

  {
    "epwalsh/pomo.nvim",
    version = "*",
    dependencies = {
      "rcarriga/nvim-notify",
    },
  },

  {
    "nvimtools/hydra.nvim",
    opts = {},
  },

  {
    "Shatur/neovim-session-manager",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },

  { "nvim-lualine/lualine.nvim" },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
    },
  },

  {
    "zaldih/themery.nvim",
    dependencies = {
      { "EdenEast/nightfox.nvim",        lazy = false, priority = 1000 },
      { "scottmckendry/cyberdream.nvim", lazy = false, priority = 1000 },
      { "folke/tokyonight.nvim",         lazy = false, priority = 1000 },
    },
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "m00qek/baleia.nvim",
      "esmuellert/codediff.nvim",
      "folke/snacks.nvim"
    },
  },

  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },

  { "lewis6991/gitsigns.nvim",  opts = {} },

  {
    "FredeHoey/tardis.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keymap = {
        ["next"] = "n", -- next entry in log (older)
        ["prev"] = "p", -- previous entry in log (newer)
      },
    },
  },

  { "sindrets/winshift.nvim" },
  { "declancm/maximize.nvim" },
  { "stevearc/stickybuf.nvim",     opts = {} },
  { "pocco81/true-zen.nvim" },
  { "folke/twilight.nvim" },
  { "folke/zen-mode.nvim" },
  { "tiagovla/scope.nvim",         opts = {},   lazy = false },
  { "HakonHarnes/img-clip.nvim",   lazy = false },
  { "norcalli/nvim-colorizer.lua", lazy = false },
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      extra_groups = {
        "NormalFloat",
        "FloatBorder",
        "FloatTitle",
      },
    },
  },
  {
    "jinh0/eyeliner.nvim",
    lazy = false,
    opts = {
      highlight_on_key = true,
      dim = true,
    },
  },
  {
    "echasnovski/mini.nvim",
    lazy = false,
    init = function()
      require("mini.surround").setup({
        mappings = {
          add = "ys",
          delete = "ds",
          find = "sf",
          find_left = "sF",
          replace = "cs",
          suffix_last = "l",
          suffix_next = "n",
        },
      })

      vim.api.nvim_set_keymap("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
      vim.api.nvim_set_keymap("n", "yss", "ys_", { noremap = false })

      require("mini.pairs").setup()
      require("mini.ai").setup()
    end,
  },
  {
    "declancm/cinnamon.nvim",
    event = "BufRead",
    opts = {},
  },
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
    "mistweaverco/kulala.nvim",
    opts = {
      global_keymaps = false,
    },
  },
  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
      },
    },
    ft = "hurl",
    opts = {},
  },
  {
    "mistricky/codesnap.nvim",
    build = "make",
    tag = "v1.6.3",
    opts = {
      mac_window_bar = false,
      title = "CodeSnap.nvim",
      bg_color = "#101010",
      has_breadcrumbs = true,
      has_line_number = true,
      show_workspace = true,
      bg_padding = 10,
      save_path = "~/",
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
      vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none", ctermbg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none", ctermbg = "none" })

      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set("n", "<A-j>", api.node.navigate.sibling.next, opts("Next Sibling"))
        vim.keymap.set("n", "<A-h>", api.node.navigate.sibling.prev, opts("Previous Sibling"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "cf", api.fs.create, opts("Create File Or Directory"))
        vim.keymap.set("n", "cd", api.fs.create, opts("Create File Or Directory"))
        vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
        vim.keymap.set("n", "gr", api.tree.reload, opts("Refresh"))
        vim.keymap.set("n", "h", api.node.navigate.parent, opts("Parent Directory"))
        vim.keymap.set("n", "H", api.node.navigate.parent_close, opts("Close Directory"))
        vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "m", api.fs.cut, opts("Cut"))
        vim.keymap.set("n", "ov", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "oh", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "oo", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
        vim.keymap.set("n", "q", api.tree.close, opts("Close"))
        vim.keymap.set("n", "R", api.fs.rename, opts("Rename"))
        vim.keymap.set("n", "th", api.filter.dotfiles.toggle, opts("Toggle Filter: Dotfiles"))
        vim.keymap.set("n", "ti", api.filter.git.ignored.toggle, opts("Toggle Filter: Git Ignore"))
        vim.keymap.set("n", "ya", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
        vim.keymap.set("n", "yf", api.fs.copy.node, opts("Copy"))
        vim.keymap.set("n", "yn", api.fs.copy.filename, opts("Copy Name"))
        vim.keymap.set("n", "yb", api.fs.copy.basename, opts("Copy Basename"))
        vim.keymap.set("n", "yr", api.fs.copy.relative_path, opts("Copy Relative Path"))
      end

      local HEIGHT_RATIO = 0.8
      local WIDTH_RATIO = 0.5
      require("nvim-tree").setup({
        on_attach = my_on_attach,
        renderer = {
          root_folder_label = ":t",
        },
        update_focused_file = {
          enable = true,
        },
        respect_buf_cwd = true,
        root_dirs = { ".git", "package.json", "Makefile" },
        view = {
          centralize_selection = true,
          float = {
            enable = true,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * WIDTH_RATIO
              local window_h = screen_h * HEIGHT_RATIO
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
              return {
                border = "rounded",
                relative = "editor",
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end,
          },
          width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
          end,
        },
      })
    end,
  },
}
