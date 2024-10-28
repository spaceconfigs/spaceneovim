local lualine_hidden = false

return {
  {
    "folke/lazy.nvim",
    keys = {
      { "<leader>feU", ":Lazy update<cr>", { desc = "update" } },
    },
  },
  {
    "tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
          terminal_colors = false,
        },
      })

      vim.cmd("colorscheme carbonfox")
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
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
                { win = "list", border = "none" },
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
      styles = {
        terminal = {
          position = "float",
          width = 0,
          height = 0,
        },
      },
      dashboard = { enabled = false },
    },
    keys = function()
      local function set_clipboard(text)
        if not text or text == "" then
          return
        end
        vim.fn.setreg("+", text)
        vim.fn.setreg("*", text)
        vim.fn.setreg('"', text)
      end

      local function filepath_with_line_abs()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname == "" then
          return nil
        end
        local line = vim.api.nvim_win_get_cursor(0)[1]
        return string.format("%s:%d", bufname, line)
      end

      local function filepath_with_line_project()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname == "" then
          return nil
        end

        local root = LazyVim.root()
        local rel

        if root and bufname:sub(1, #root) == root then
          rel = bufname:sub(#root + 2)
        else
          rel = vim.fn.fnamemodify(bufname, ":.")
        end

        local line = vim.api.nvim_win_get_cursor(0)[1]
        return string.format("%s:%d", rel, line)
      end

      return {
        {
          "<leader><leader>",
          function()
            Snacks.picker.commands()
          end,
          desc = "Commands",
        },

        {
          "<leader><tab>",
          ":edit #<cr>",
          desc = "Switch to alternate file",
        },
        {
          "<leader>?",
          function()
            Snacks.picker.keymaps()
          end,
          desc = "Keymaps",
        },

        {
          "<leader>Ts",
          function()
            Snacks.picker.colorschemes()
          end,
          desc = "Colorschemes",
        },

        {
          "<leader>bb",
          function()
            Snacks.picker.buffers()
          end,
          desc = "List",
        },

        {
          "<leader>bd",
          function()
            Snacks.bufdelete()
          end,
          desc = "Delete",
        },

        {
          "<leader>el",
          function()
            Snacks.picker.diagnostics_buffer()
          end,
          desc = "List",
        },

        {
          "<leader>en",
          function()
            vim.diagnostic.jump({ count = 1 })
          end,
          desc = "Next",
        },

        {
          "<leader>ep",
          function()
            vim.diagnostic.jump({ count = -1 })
          end,
          desc = "Previous",
        },

        {
          "<leader>feU",
          ":Lazy update<cr>",
          desc = "Update",
        },

        {
          "<leader>ff",
          function()
            Snacks.picker.files({ cwd = vim.fn.expand("%:p:h") })
          end,
          desc = "Find (cwd)",
        },

        { "<leader>fr", LazyVim.pick("oldfiles"), desc = "Recent" },

        {
          "<leader>fs",
          ":write<cr>",
          mode = { "n", "x" },
          desc = "Save",
        },
        {
          "<leader>ft",
          function()
            Snacks.explorer({ cwd = LazyVim.root() })
          end,
          mode = { "n", "x" },
          desc = "Explorer",
        },
        {
          "<leader>fyL",
          function()
            local text = filepath_with_line_project()
            set_clipboard(text)
          end,
          desc = "File path + line (project)",
        },
        {
          "<leader>fyl",
          function()
            local text = filepath_with_line_abs()
            set_clipboard(text)
          end,
          desc = "File path + line (absolute)",
        },

        {
          "<leader>hh",
          function()
            Snacks.picker.help()
          end,
          desc = "Packages",
        },

        {
          "<leader>m==",
          function()
            LazyVim.format({ force = true })
          end,
          mode = { "n", "x" },
          desc = "Format",
        },

        {
          "<leader>p'",
          function()
            Snacks.terminal.toggle(nil, { cwd = LazyVim.root() })
          end,
          desc = "Terminal",
        },

        { "<leader>pf", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },

        {
          "<leader>pp",
          function()
            Snacks.picker.projects()
          end,
          desc = "Projects",
        },

        { "<leader>ps", LazyVim.pick("grep"), desc = "Grep (Root Dir)" },

        {
          "<leader>sl",
          function()
            Snacks.picker.resume()
          end,
          desc = "Resume",
        },

        {
          "<leader>sp",
          LazyVim.pick("live_grep"),
          desc = "Project",
        },

        {
          "<leader>ss",
          function()
            Snacks.picker.lines({ layout = { preset = "nitaicharan_lines" } })
          end,
          desc = "Line",
        },
        {
          "<leader>sS",
          function()
            Snacks.picker.grep_word()
          end,
          desc = "Search on cursor",
        },
        { "<leader>up", false },
        {
          "<leader>ws",
          ":split | wincmd p<cr>",
          desc = "VSplit",
        },
        {
          "<leader>wS",
          ":split<cr>",
          desc = "VSplit & focus",
        },
        {
          "<leader>wv",
          ":vsplit | wincmd p<cr>",
          desc = "Split",
        },
        {
          "<leader>wV",
          ":vsplit<cr>",
          desc = "Split & focus",
        },

        {
          "<leader>wd",
          "<C-W>c",
          desc = "Delete",
        },

        {
          "<leader>wh",
          "<C-w>h",
          desc = "Go Left",
        },

        {
          "<leader>wj",
          "<C-w>j",
          desc = "Go Down",
        },

        {
          "<leader>wk",
          "<C-w>k",
          desc = "Go Up",
        },

        {
          "<leader>wl",
          "<C-w>l",
          desc = "Go Right",
        },

        {
          "<leader>wpP",
          function()
            Snacks.notifier.hide()
          end,
          desc = "Dismiss",
        },

        {
          "<leader>wpm",
          function()
            Snacks.picker.notifications()
          end,
          desc = "List",
        },
      }
    end,
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.spec = opts.spec or {}
      vim.list_extend(opts.spec, {
        { "<leader>b", group = "Buffers" },
        { "<leader>e", group = "Erros" },
        { "<leader>f", group = "Files" },
        { "<leader>fe", group = "Config" },
        { "<leader>fy", group = "Copy" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Help" },
        { "<leader>l", group = "Layouts" },
        { "<leader>m", group = "Major" },
        { "<leader>mg", group = "Go to" },
        { "<leader>p", group = "Projects" },
        { "<leader>q", group = "Quit" },
        { "<leader>s", group = "Search" },
        { "<leader>T", group = "Toggle" },
        { "<leader>w", group = "Windows" },
        { "<leader>wp", group = "Notifications" },
      })

      opts.preset = "modern"
      opts.win = {
        padding = { 2, 2 }, -- extra window padding [top/bottom, right/left]
        wo = {},
      }
      opts.layout = {
        align = "center", -- align columns center
      }

      return opts
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        ["*"] = {
          keys = {
            { "<leader>cA", false },
            { "<leader>cC", false },
            { "<leader>cR", false },
            { "<leader>ca", false },
            { "<leader>cc", false },
            { "<leader>cl", false },
            { "<leader>cr", false },
            { "<leader>ss", false },
            { "<leader>sS", false },
            {
              "<leader>mgd",
              function()
                Snacks.picker.lsp_definitions()
              end,
              desc = "Goto Definition",
              has = "definition",
            },
            {
              "<leader>mgi",
              function()
                Snacks.picker.lsp_implementations()
              end,
              desc = "Goto Implementation",
            },
            {
              "<leader>mgr",
              function()
                Snacks.picker.lsp_references()
              end,
              nowait = true,
              desc = "References",
            },
            {
              "<leader>mgt",
              function()
                Snacks.picker.lsp_type_definitions()
              end,
              desc = "Goto T[y]pe Definition",
            },
          },
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    keys = function()
      return {
        { "<leader>b<C-d>", ":BufferLineCloseOthers<CR>", desc = "Close others" },
        { "<leader>bn", ":BufferLineCycleNext<cr>", desc = "Next" },
        { "<leader>bp", ":BufferLineCyclePrev<cr>", desc = "Preview" },
      }
    end,
  },
  {
    "Shatur/neovim-session-manager",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local config = require("session_manager.config")

      require("session_manager").setup({
        autoload_mode = config.AutoloadMode.Disabled,
        autosave_last_session = false,
        autosave_only_in_session = false,
      })
    end,
    keys = function()
      return {
        {
          "<leader>l<Tab>",
          function()
            require("session_manager").load_last_session()
          end,
          desc = "Last",
        },
        {
          "<leader>lD",
          function()
            require("session_manager").delete_session()
          end,
          desc = "Delete",
        },
        {
          "<leader>lL",
          function()
            require("session_manager").load_current_dir_session()
          end,
          desc = "Reload",
        },
        {
          "<leader>ll",
          function()
            require("session_manager").load_session(false)
          end,
          desc = "List",
        },
        {
          "<leader>ls",
          function()
            require("session_manager").save_current_session()
          end,
          desc = "Save",
        },
      }
    end,
  },
  {
    "nvim-mini/mini.comment",
    keys = {
      {
        "<leader>;",
        mode = "x",
        function()
          local from = vim.fn.line("v")
          local to = vim.fn.line(".")
          if from > to then
            from, to = to, from
          end
          require("mini.comment").toggle_lines(from, to)
        end,
        desc = "Comment",
      },
      {
        "<leader>;",
        mode = "n",
        function()
          local line = vim.fn.line(".")
          require("mini.comment").toggle_lines(line, line)
        end,
        desc = "Comment",
      },
    },
  },
  {
    "NeogitOrg/neogit",
    keys = {
      {
        "<leader>gs",
        mode = { "n", "x" },
        function()
          require("neogit").open({ kind = "auto" })
        end,
        desc = "Status",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "<leader>gb",
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        desc = "Blame",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        vim.keymap.set("n", "<leader>gb", function()
          gs.blame_line()
        end, { desc = "Blame Line", buffer = buffer, silent = true })
      end,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    keys = {
      {
        "<leader>tmT",
        function()
          local lualine = require("lualine")
          if lualine_hidden then
            lualine.hide({ unhide = true })
          else
            lualine.hide()
          end

          lualine_hidden = not lualine_hidden
        end,
        desc = "Toggle Statusline",
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {},
    keys = {
      {
        "<leader>'",
        function()
          local bufname = vim.api.nvim_buf_get_name(0)
          local dir = (bufname ~= "" and vim.fs.dirname(bufname)) or vim.loop.cwd()

          vim.cmd(string.format("ToggleTerm dir=%s", dir))
        end,
        desc = "Terminal (buffer dir)",
      },
      {
        "<Esc>",
        [[<C-\><C-n>]],
        mode = "t", -- terminal mode
        desc = "Terminal: exit to Normal mode",
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    specs = { "Kaiser-Yang/blink-cmp-avante" },
    opts = {
      completion = {
        ghost_text = {
          enabled = true,
          show_with_menu = false,
        },
        menu = {
          auto_show = false,
        },
      },
      cmdline = {
        enabled = true,
        keymap = {
          ["<Right>"] = { "accept" },
        },
        sources = { "buffer", "cmdline" },
        completion = {
          trigger = {
            show_on_blocked_trigger_characters = {},
            show_on_x_blocked_trigger_characters = {},
          },
          list = {
            selection = {
              preselect = true,
              auto_insert = true,
            },
          },
          menu = { auto_show = false },
          ghost_text = { enabled = true },
        },
      },
      sources = {
        default = { "avante" },
        providers = { avante = { module = "blink-cmp-avante", name = "Avante" } },
      },
      keymap = {
        ["<CR>"] = nil,
        ["<Right>"] = { "accept" },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
      },
      popupmenu = {
        enabled = true,
      },
      views = {
        cmdline_popup = {
          position = {
            row = "50%",
            col = "50%",
          },
        },
      },
    },
    keys = false,
  },
  {
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    opts = {
      provider = "gemini",
      providers = {
        gemini = {
          api_key_name = { "pass", "ai.google.dev/token" },
          temperature = 0,
          max_tokens = 2048,
        },
      },
      selection = {
        hint_display = "none",
      },
      behaviour = {
        auto_set_keymaps = false,
      },
    },
    cmd = {
      "AvanteAsk",
      "AvanteBuild",
      "AvanteChat",
      "AvanteClear",
      "AvanteEdit",
      "AvanteFocus",
      "AvanteHistory",
      "AvanteModels",
      "AvanteRefresh",
      "AvanteShowRepoMap",
      "AvanteStop",
      "AvanteSwitchProvider",
      "AvanteToggle",
    },
    keys = {
      { "<leader>aa", "<cmd>AvanteAsk<CR>", desc = "Ask Avante" },
      { "<leader>ac", "<cmd>AvanteChat<CR>", desc = "Chat with Avante" },
      { "<leader>ae", "<cmd>AvanteEdit<CR>", desc = "Edit Avante" },
      { "<leader>af", "<cmd>AvanteFocus<CR>", desc = "Focus Avante" },
      { "<leader>ah", "<cmd>AvanteHistory<CR>", desc = "Avante History" },
      { "<leader>am", "<cmd>AvanteModels<CR>", desc = "Select Avante Model" },
      { "<leader>an", "<cmd>AvanteChatNew<CR>", desc = "New Avante Chat" },
      { "<leader>ap", "<cmd>AvanteSwitchProvider<CR>", desc = "Switch Avante Provider" },
      { "<leader>ar", "<cmd>AvanteRefresh<CR>", desc = "Refresh Avante" },
      { "<leader>as", "<cmd>AvanteStop<CR>", desc = "Stop Avante" },
      { "<leader>at", "<cmd>AvanteToggle<CR>", desc = "Toggle Avante" },
    },
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "Kaiser-Yang/blink-cmp-avante" },
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        optional = true,
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        optional = true,
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  { "stevearc/conform.nvim", keys = false },
  { "mason-org/mason.nvim", keys = false },
  { "folke/trouble.nvim", keys = false },
  { "MagicDuck/grug-far.nvim", keys = false },
  { "folke/flash.nvim", keys = false },
  { "folke/todo-comments.nvim", keys = false },
  { "nvim-telescope/telescope.nvim", keys = false },
  { "nvim-mini/mini.pairs", keys = false },
  { "nvim-mini/mini.ai", keys = false },
  { "folke/persistence.nvim", keys = false },
}
