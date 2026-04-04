return {
  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
			require("gitsigns").setup()
		end,
  },

  -- diagnostics: The "Error List" at the bottom
  -- {
  --   "folke/trouble.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   opts = {},
  --   keys = {
  --     { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
  --     { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
  --   },
  -- },
  -- open or collapse blocks using tree-sitter
  -- za - toggle open/close, zc close, zo open, zM close all, zR open all
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      -- UFO needs a higher foldlevel to start open
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99 
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          if filetype == 'markdown' then
            return {'treesitter', 'indent'}
          end
          return {'lsp', 'indent'}
        end
      })
    end
  },
  -- shows status column
  -- {
  --   "luukvbaal/statuscol.nvim",
  --   config = function()
  --     local builtin = require("statuscol.builtin")
  --     require("statuscol").setup({
  --       relculright = true,
  --       segments = {
  --         -- Fold Column (UFO)
  --         { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
  --         -- Sign Column (Git & Diagnostics)
  --         { sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true }, click = "v:lua.ScSa" },
  --         -- Line Numbers
  --         { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
  --       },
  --     })
  --   end,
  -- },
}
