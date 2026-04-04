return {
	-- Surround text objects easily
	-- ds, cs, ys 
  {
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
    end,
  },
	-- Automatically add pair i.e. (), [], {}, etc.
	{
		"nvim-mini/mini.pairs",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	-- Show indent level.
	--{
	--	"nvim-mini/mini.indentscope",
	--	version = "*",
	--	config = function()
	--		require("mini.indentscope").setup()
	--	end,
	--},
	-- highlight word under cursor
	--{
	--	"nvim-mini/mini.cursorword",
	--	config = function()
	--		require("mini.cursorword").setup()
	--	end,
	--},
  -- split navigation in neotree (Alt+hjkl)
  {
    "christoomey/vim-tmux-navigator",
    config = function()
      vim.keymap.set('n', '<M-h>', '<cmd>wincmd h<cr>')
      vim.keymap.set('n', '<M-j>', '<cmd>wincmd j<cr>')
      vim.keymap.set('n', '<M-k>', '<cmd>wincmd k<cr>')
      vim.keymap.set('n', '<M-l>', '<cmd>wincmd l<cr>')
    end
  },
  -- --help for keybindings
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   init = function()
  -- 	vim.o.timeout = true
  -- 	vim.o.timeoutlen = 300
  -- end,
  --   opts = {},
  --   keys = {
  --     {
  --       "<leader>?",
  --       function()
  --         require("which-key").show({ global = false })
  --       end,
  --       desc = "Buffer Local Keymaps (which-key)",
  --     },
  --   },
  -- }
}
