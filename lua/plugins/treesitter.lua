return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "master",
  lazy = false,
  opts = {
    ensure_installed = {
      "lua", "vim", "vimdoc", "query",
      "go", "gomod", "gosum", "gowork",
      "python",
      "html", "javascript", "typescript", "tsx", "css",
      "bash", "make",
      "markdown", "markdown_inline",
      "gitcommit", "dockerfile", "hcl", "terraform",
      "xml", "json", "toml", "yaml", "sql", "regex",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    -- nicest helper to select
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "v",
        node_incremental = "v",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

-- using the main one, but needs neovim 0.12.0
-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--     lazy = false,
--     branch = "main",
--     build = ":TSUpdate",
--     config = function()
--       require("nvim-treesitter").install("stable")
--       vim.keymap.set("n", "<leader>th", vim.treesitter.start, { desc = "start treesitter" })
--       vim.api.nvim_create_autocmd("FileType", {
--         pattern = {
--           "lua", "vim", "vimdoc",
--           "go", "gomod", "gosum", "gowork",
--           "python",
--           "html", "javascript", "javascriptreact", "jsx",
--           "css", "typescript", "typescriptreact", "tsx",
--           "bash", "make",
--           "markdown", "markdown_inline",
--           "dockerfile", "hcl", "terraform",
--           "xml", "json", "toml", "yaml", "sql", "regex",
--         },
--         callback = function()
--           pcall(vim.treesitter.start)
--         end,
--       })
--     end,
--   },
-- }
