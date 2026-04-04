return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  config = function()
    require("mason").setup()

    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, {
      offsetEncoding = { "utf-16" },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "gopls",
        "html",
        "emmet_ls",
        "vtsls",
        "tailwindcss",
        "bashls",
        "marksman",
        "pyright",
        "rust_analyzer",
        "dockerls",
        "hyprls",
        "lemminx",
        "jsonls",
        "taplo",
        "yamlls",
      },
      automatic_installation = true,
      handlers = {
        function(server)
          local server_opts = {
            capabilities = capabilities,
            root_markers = { ".git" },
          }
          lspconfig[server].setup(server_opts)
        end,
        ["lua_ls"] = function(opts)
          lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", opts, {
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
              },
            },
          }))
        end,
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buf = args.data.buf
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Definition")
        map("n", "gD", vim.lsp.buf.declaration, "Declaration")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "gi", vim.lsp.buf.implementation, "Implementation")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "grf", vim.lsp.buf.format, "Format")
        map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
      end,
    })
  end,
}
