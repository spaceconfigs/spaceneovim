local vim = vim

local make_logged = require("application.helpers.make_logged")
local jumper_use_case = require("application.use_cases.jumper")
local plugin = require("infrastructure.plugins.registry").lsp()
local mason_lspconfig = plugin.mason_lspconfig
local blink_cmp = plugin.blink_cmp
local snacks = plugin.snacks

local severity = vim.diagnostic.severity
vim.diagnostic.config({
  signs = {
    text = {
      -- [severity.ERROR] = " ",
      [severity.ERROR] = " ", -- error
      -- [severity.WARN] = " ",
      [severity.WARN] = " ", -- warning
      -- [severity.INFO] = " ",
      [severity.INFO] = " ", -- info
      -- [severity.HINT] = "󰌵",
      [severity.HINT] = "󰌶", -- hint (added a nice lightbulb icon)
    },
  },
})

local blink_capabilities = blink_cmp.get_lsp_capabilities()
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local capabilities = vim.tbl_deep_extend("force", blink_capabilities, lsp_capabilities)
local servers = mason_lspconfig.get_installed_servers()

local server_overrides = {
  eslint = {
    root_dir = function(bufnr, on_dir)
      local root = vim.fs.root(bufnr,
        { "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", ".eslintrc.json", ".eslintrc.js", ".eslintrc" })

      if root then on_dir(root) end
    end,
  },
  ts_ls = {
    root_dir = function(bufnr, on_dir)
      local node_markers = { "package.json", "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
      local deno_markers = { "deno.json", "deno.jsonc", "deno.lock" }

      local node_root = vim.fs.root(bufnr, node_markers)
      local deno_root = vim.fs.root(bufnr, deno_markers)

      if deno_root and (not node_root or #deno_root > #node_root) then
        -- vim.notify('deno_root')
        on_dir(deno_root or vim.fs.root(bufnr, { ".git" }))
        return
      end

      on_dir(node_root or vim.fs.root(bufnr, { ".git" }))
    end,
  },
}

for _, server in ipairs(servers) do
  local config = vim.tbl_deep_extend("force", { capabilities = capabilities }, server_overrides[server] or {})

  -- require('lspconfig')[server].setup(config)
  vim.lsp.config(server, config)
  vim.lsp.enable(servers)
end

local navigate_dispatch = {
  declaration = function() snacks.picker.lsp_declarations() end,
  definition = function() snacks.picker.lsp_definitions() end,
  implementation = function() vim.lsp.buf.implementation() end,
  references = function() snacks.picker.lsp_references() end,
  typedefinition = function() vim.lsp.buf.type_definition() end,
}

---@type LspPort
local M = {
  navigate = function(type, options)
    local action = navigate_dispatch[type]

    if options.type == "remote" then
      jumper_use_case.timer({
        action = function(match)
          vim.api.nvim_win_call(match.win, function()
            vim.api.nvim_win_set_cursor(match.win, match.pos)
            action()
          end)
        end,
      })
      return
    end

    action()
  end,

  restart = function()
    for _, client in ipairs(vim.lsp.get_clients()) do
      client:stop()
    end

    vim.cmd("edit")
  end,

  rename = function()
    vim.lsp.buf.rename()
  end,

  show_signature = function()
    vim.lsp.buf.signature_help()
  end,

  show_documentation = function()
    vim.lsp.buf.hover()
  end,

  show_code_action = function()
    vim.lsp.buf.code_action()
  end,

  format = function()
    vim.lsp.buf.format({ async = true })
  end,

  diagnostics = function()
    vim.lsp.diagnostic()
  end,

  info = function()
    vim.cmd("LspInfo")
  end,

  get_symbol = function()
    snacks.picker.lsp_symbols()
  end,
}

return make_logged("adapters/lsp", M)
