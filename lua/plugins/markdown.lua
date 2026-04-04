return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { 
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons"
    },
    lazy = true,
    opts = {
      mermaid = {
        enabled = true,
        render = true
      }
    },
    config = function()
			require("render-markdown").setup({
				completions = { lsp = { enabled = true } },
			})
      -- enfore 2 tabs in markdown always
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.softtabstop = 2
          vim.opt_local.expandtab = true
        end,
      })
    end,
    keys = {
      { "<leader>md", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown preview" }
    }
  },
}
