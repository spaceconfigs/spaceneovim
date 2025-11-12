return {
  { "folke/lazy.nvim", optional = true, keys = false },
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
    optional = true,
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
    },
    styles = {
      terminal = {
        position = "float",
        width = 0,
        height = 0,
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader><leader>",
        function()
          Snacks.picker.commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>bb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files({ cwd = vim.fn.expand("%:p:h") })
        end,
        desc = "Find Files (cwd)",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Find Files (git-files)",
      },
      { "<leader>fr", LazyVim.pick("oldfiles"), desc = "Recent" },
      {
        "<leader>fR",
        function()
          Snacks.picker.recent({ filter = { cwd = true } })
        end,
        desc = "Recent (cwd)",
      },
      {
        "<leader>pp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      { "<leader>ps", LazyVim.pick("grep"), desc = "Grep (Root Dir)" },
      { "<leader>pf", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      --{
      --  "<leader>sb",
      --  function()
      --    Snacks.picker.lines()
      --  end,
      --  desc = "Buffer Lines",
      --},
      --{
      --  "<leader>sB",
      --  function()
      --    Snacks.picker.grep_buffers()
      --  end,
      --  desc = "Grep Open Buffers",
      --},
      {
        "<leader>wpm",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      { "<leader>sp", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>sd", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      {
        "<leader>sR",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },
      {
        "<leader>el",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>hh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help Pages",
      },
      {
        "<leader>sl",
        function()
          Snacks.picker.loclist()
        end,
        desc = "Location List",
      },
      {
        "<leader>sq",
        function()
          Snacks.picker.qflist()
        end,
        desc = "Quickfix List",
      },
      {
        "<leader>Ts",
        function()
          Snacks.picker.colorschemes()
        end,
        desc = "Colorschemes",
      },
    },
  },

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
        { "<leader>m", group = "Major" },
        { "<leader>mg", group = "Go to" },
        { "<leader>p", group = "Projects" },
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
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        ["*"] = {
          -- stylua: ignore
          keys = {
            { "<leader>mgd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", has = "definition" },
            { "<leader>mgr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            { "<leader>mgi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
            { "<leader>mgt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
            { "<leader>ss", function() Snacks.picker.lines({ layout = { preset = "nitaicharan_lines" }}) end, desc = "Buffer Lines", },
          },
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    keys = {
      {
        "<leader>bn",
        ":BufferLineCycleNext<cr>",
        desc = "Goto Implementation",
      },
      {
        "<leader>bp",
        ":BufferLineCyclePrev<cr>",
        desc = "Goto Implementation",
      },
    },
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
    keys = {
      {
        "<leader>ll",
        function()
          require("session_manager").load_session(false)
        end,
        desc = "Keymaps",
      },
      {
        "<leader>ls",
        function()
          require("session_manager").save_current_session()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>lL",
        function()
          require("session_manager").load_current_dir_session()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>lD",
        function()
          require("session_manager").delete_session()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>l<Tab>",
        function()
          require("session_manager").load_last_session()
        end,
        desc = "Keymaps",
      },
    },
  },
}
