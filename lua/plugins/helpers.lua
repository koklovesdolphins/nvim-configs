return {
	-- Surround text objects easily
	-- ds, cs, ys (add)
  -- ysiw - surround word with
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
	-- {
	-- 	"nvim-mini/mini.pairs",
	-- 	version = "*",
	-- 	config = function()
	-- 		require("mini.pairs").setup()
	-- 	end,
	-- },
	-- mutli cursor
  -- ctrl + v for visual block mode
  -- Caps I (add) - or visual block d (delete)
  -- type
  -- esc --- it should then insert on all lines

  -- highlight word under cursor (maybe not that usefule with incremental treesitter)
	--{
	--	"nvim-mini/mini.cursorword",
	--	config = function()
	--		require("mini.cursorword").setup()
	--	end,
	--},
	-- split navigation in neotree (Alt+hjkl)
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		init = function()
			-- disable vim-tmux-navigator's own <C-hjkl>; vim-herdr-navigation's
			-- editor/nvim.lua (below) replaces them so edge-crossing calls herdr
			-- instead of tmux directly (herdr forwards ctrl+hjkl here when its
			-- alt+hjkl binding detects a focused Vim/Neovim pane).
			vim.g.tmux_navigator_no_mappings = 1
		end,
		config = function()
			vim.keymap.set("n", "<M-h>", "<cmd>wincmd h<cr>")
			vim.keymap.set("n", "<M-j>", "<cmd>wincmd j<cr>")
			vim.keymap.set("n", "<M-k>", "<cmd>wincmd k<cr>")
			vim.keymap.set("n", "<M-l>", "<cmd>wincmd l<cr>")

			local plugin_root = vim.fn.glob("~/.config/herdr/plugins/github/vim-herdr-navigation-*", false, true)[1]
			if plugin_root and plugin_root ~= "" then
				dofile(plugin_root .. "/editor/nvim.lua")
			end
		end,
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
