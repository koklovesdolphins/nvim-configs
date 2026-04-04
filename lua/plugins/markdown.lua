return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { 
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons"
    },
    lazy = true,
    opts = {
      mermain = {
        enabled = true,
        render = false
      }
    },
    config = function()
			require("render-markdown").setup({
				completions = { lsp = { enabled = true } },
			})
		end,
    keys = {
      { "<leader>md", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown preview" }
    }
  },
}
