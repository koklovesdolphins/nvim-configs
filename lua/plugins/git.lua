return {
	-- 1. Gitsigns (Inline/Hunk management)
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			preview_config = { border = "rounded" },
			signs = {
				add          = { text = "▎" },
				change       = { text = "▎" },
				delete       = { text = "▸" },
				topdelete    = { text = "▸" },
				changedelete = { text = "▎" },
				untracked    = { text = "▎" },
			},
			signs_staged_enable = true,
			signs_staged = {
				add          = { text = "▎" },
				change       = { text = "▎" },
				delete       = { text = "▸" },
				topdelete    = { text = "▸" },
				changedelete = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				-- Navigation to hunks
				map("n", "]h", function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function()
						gs.nav_hunk("next")
					end)
					return "<Ignore>"
				end, "Next Hunk")

				map("n", "[h", function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function()
						gs.nav_hunk("prev")
					end)
					return "<Ignore>"
				end, "Prev Hunk")

				-- Hunk Actions
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk")
				map("n", "<leader>ghs", gs.stage_hunk, "Stage Hunk")
				map("n", "<leader>ghr", gs.reset_hunk, "Reset Hunk")

				-- git lens
				map("n", "<leader>glb", gs.blame_line, "Blame Line")
			end,
		},
	},

	-- 2. Diffview (Deep review / History) FzfLua git_status feels better
	-- {
	-- 	"sindrets/diffview.nvim",
	-- 	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	-- 	keys = {
	-- 		{
	-- 			"<leader>gd",
	-- 			function()
	-- 				local view = require("diffview.lib").get_current_view()
	-- 				if view then
	-- 					vim.cmd("DiffviewClose")
	-- 				else
	-- 					vim.cmd("DiffviewOpen")
	-- 				end
	-- 			end,
	-- 			desc = "Toggle Diffview",
	-- 		},
	-- 		{ "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (Current)" },
	-- 		{ "<leader>gdH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (Repo)" },
	-- 	},
	-- },

	-- 3. Scrollbar with git hunk markers (VSCode-style right-side overview)
	{
		"petertriho/nvim-scrollbar",
		dependencies = { "lewis6991/gitsigns.nvim" },
		event = "BufReadPost",
		config = function()
			require("scrollbar").setup({
				show_in_active_only = true,
				handle = { highlight = "Visual" },
				marks = {
					GitAdd    = { text = "▎" },
					GitChange = { text = "▎" },
					GitDelete = { text = "▸" },
				},
			})
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},

	-- 4. Neogit (Maybe move to fugitive?)
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
		opts = { integrations = { diffview = true } },
		keys = {
			{
				"<leader>ngg",
				function()
					local neogit = require("neogit")
					local is_open = false
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[buf].filetype == "NeogitStatus" then
							is_open = true
							break
						end
					end

					if is_open then
						vim.cmd("pclose") -- Closes preview windows if open
						neogit.close()
					else
						neogit.open()
					end
				end,
				desc = "Neogit Toggle",
			},
		},
	},
}
