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
      return {
        { "<leader>up", false },
        { "<leader>?", false },
        {
          "<leader><leader>",
          function()
            Snacks.picker.commands()
          end,
          desc = "Commands",
        },
        {
          "<leader>?",
          function()
            Snacks.picker.keymaps()
          end,
          desc = "Keymaps",
        },
        {
          "<leader>bb",
          function()
            Snacks.picker.buffers()
          end,
          desc = "List",
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
          desc = "Next diagnostic",
        },
        {
          "<leader>ep",
          function()
            vim.diagnostic.jump({ count = -1 })
          end,
          desc = "Previous diagnostic",
        },
        {
          "<leader>ff",
          function()
            Snacks.picker.files({ cwd = vim.fn.expand("%:p:h") })
          end,
          desc = "Find Files (cwd)",
        },
        { "<leader>fr", LazyVim.pick("oldfiles"), desc = "Recent" },
        {
          "<leader>hh",
          function()
            Snacks.picker.help()
          end,
          desc = "Packages",
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
          "<leader>ss",
          function()
            Snacks.picker.lines({ layout = { preset = "nitaicharan_lines" } })
          end,
          desc = "Line",
        },
        { "<leader>sp", LazyVim.pick("live_grep"), desc = "Project" },
        {
          "<leader>Ts",
          function()
            Snacks.picker.colorschemes()
          end,
          desc = "Colorschemes",
        },
        {
          "<leader>wpm",
          function()
            Snacks.picker.notifications()
          end,
          desc = "List",
        },
        {
          "<leader>wpP",
          function()
            Snacks.notifier.hide()
          end,
          desc = "Dismiss",
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
        {
          "<leader>bn",
          ":BufferLineCycleNext<cr>",
          desc = "Next",
        },
        {
          "<leader>bp",
          ":BufferLineCyclePrev<cr>",
          desc = "Preview",
        },
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
    "folke/noice.nvim",
    opts = {
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
