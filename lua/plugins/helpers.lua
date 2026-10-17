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
	-- split navigation, all on alt+arrow
	--   herdr: bin/vim-nav.sh forwards alt+arrow into a Vim pane
	--   tmux:  vim-tmux-navigator's @vim_navigator_mapping_* forward it too
	--   vim:   alt+hjkl moves between splits only, never crossing out
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		init = function()
			-- the plugin's own <C-hjkl> maps stay off; its :TmuxNavigate*
			-- commands still load and the handler below calls them.
			vim.g.tmux_navigator_no_mappings = 1
		end,
		config = function()
			vim.keymap.set("n", "<M-h>", "<cmd>wincmd h<cr>")
			vim.keymap.set("n", "<M-j>", "<cmd>wincmd j<cr>")
			vim.keymap.set("n", "<M-k>", "<cmd>wincmd k<cr>")
			vim.keymap.set("n", "<M-l>", "<cmd>wincmd l<cr>")

			-- Move within Neovim first. If the cursor window did not change, we
			-- sit at a split edge and must hand off to the surrounding
			-- multiplexer. `dir` is "left"/"down"/"up"/"right".
			local tmux_cmd = { left = "Left", down = "Down", up = "Up", right = "Right" }
			local function cross_out(dir)
				-- herdr first: when both are set we are nested, and herdr is outermost
				if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
					local herdr = vim.env.HERDR_BIN_PATH
					if herdr == nil or herdr == "" then
						herdr = "herdr"
					end
					vim.fn.system({ herdr, "pane", "focus", "--direction", dir, "--current" })
				elseif vim.env.TMUX and vim.env.TMUX ~= "" then
					pcall(vim.cmd, "TmuxNavigate" .. tmux_cmd[dir])
				end
			end

			local function nav(wincmd, dir)
				local prev = vim.api.nvim_get_current_win()
				vim.cmd("wincmd " .. wincmd)
				if vim.api.nvim_get_current_win() == prev then
					cross_out(dir)
				end
			end

			for lhs, move in pairs({
				["<M-Left>"] = { "h", "left" },
				["<M-Down>"] = { "j", "down" },
				["<M-Up>"] = { "k", "up" },
				["<M-Right>"] = { "l", "right" },
			}) do
				vim.keymap.set("n", lhs, function()
					nav(move[1], move[2])
				end, { silent = true, desc = "Navigate " .. move[2] .. " (vim/herdr/tmux)" })
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
