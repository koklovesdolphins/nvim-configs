return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = 'master', 
  lazy = false,
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { 
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "javascript",
        "python",
        "go",
        "hcl",
        "yaml",
        "json",
        "sql",
        "bash",
        "dockerfile"
      },
      highlight = {enable = true, nested = true},
      indent = {enable = true},
    })
  end
}
