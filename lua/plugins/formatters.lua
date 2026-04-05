local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "prettierd",
        "prettier",
        "stylua",
        "gofumpt",
        "goimports",
        "shfmt",
        "taplo",
        "sql-formatter",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        --lua
        lua = { "stylua" },

        -- web
        javascript = prettier,
        typescript = prettier,
        javascriptreact = prettier,
        typescriptreact = prettier,
        html = prettier,
        css = prettier,
        scss = prettier,

        -- code
        python = { "ruff_organize_imports", "ruff_format" },
        go = { "goimports", "gofumpt" },

        --shell
        sh = { "shfmt" },

        --note
        markdown = prettier,

        -- data/config
        yaml = prettier,
        toml = { "taplo" },
        json = prettier,
        sql = { "sql_formatter" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
