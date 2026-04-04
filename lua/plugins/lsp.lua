local ensure_installed = {
  "lua_ls",
  "gopls",
  "pyright",
  "ts_ls", "html", "cssls",
  "terraformls", "dockerls", "bashls"
}
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "Saghen/blink.cmp",
    },
    config = function()
      -- 1. Setup Mason to manage your binaries
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
      })

      -- 2. Get capabilities for auto-completion (from blink.cmp)
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- 3. Define your servers
      local servers = ensure_installed

      -- 4. Native Configuration (The 0.11 Way)
      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities
        })
      end

      -- Custom logic for Lua (to recognize 'vim' global)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })

      -- 5. Actually turn them on
      vim.lsp.enable(vim.list_extend({ "lua_ls" }, servers))

      -- 6. Keymaps (Standard LspAttach)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
