return {
	{
		"stevearc/oil.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"refractalize/oil-git-status.nvim",
		},
		lazy = false,
		config = function()
			require("oil").setup({
				default_file_explorer = false,
				view_options = {
					show_hidden = true,
					is_hidden_file = function(name, _)
						return name == ".git"
					end,
				},
				win_options = {
					signcolumn = "yes:2",
				},
				keymaps = {
					["q"] = "actions.close",
				},
				float = {
					padding = 2,
					max_width = 80,
					max_height = 30,
					border = "rounded",
				},
			})
			require("oil-git-status").setup()
			vim.keymap.set("n", "<leader>o", ":Oil --float<CR>", { desc = "Open Oil file explorer" })
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- for gliphs with nerdfonts
		},
		lazy = false,
		config = function()
			require("neo-tree").setup({
				commands = {
					copy_path = function(state)
						local node = state.tree:get_node()
						vim.fn.setreg("+", node.path)
						vim.notify("Copied: " .. node.path)
					end,
					open_in_tmux = function(state)
						local node = state.tree:get_node()
						local id = node:get_id()
						if node.type == "directory" then
							vim.fn.jobstart("tmux new-window -c " .. vim.fn.shellescape(id))
						else
							vim.fn.jobstart("tmux new-window -c " .. vim.fn.shellescape(vim.fs.dirname(id)))
						end
						vim.notify("Opened in new tmux window")
					end,
					-- rebind enter to open file but stay in neotree
					open_keep_focus = function(state)
						local neo_tree_win = vim.api.nvim_get_current_win()
						local node = state.tree:get_node()
						state.commands["open"](state)
						if node.type == "file" then
							vim.api.nvim_set_current_win(neo_tree_win)
						end
					end,
				},
				window = {
					position = "float",
					mappings = {
						["Y"] = "copy_path",
						["T"] = "open_in_tmux",
						["<cr>"] = "open_keep_focus",
						["O"] = "open",
					},
				},
			})
			vim.keymap.set("n", "<leader>e", ":Neotree float reveal toggle<CR>", { desc = "Toggle file tree" })
			-- a - new file/folder
			-- r - rename
			-- y - copy file
			-- x - cut file
			-- p - paste
			-- d - delete
			-- D - search by directory name
			-- / - search by file name
			-- backspace - change root to parent
			-- . - change root to enter
			-- shift + h - show hidden
			-- ctrl w + arrow to move between window (can use vim-tmux-navigator)
			-- s - split right window
			-- S - split below window
			-- ctrl w + q - to close split (or qs keybind)
			-- t - new tab
			-- gt - toggle between tabs
		end,
	},
}
