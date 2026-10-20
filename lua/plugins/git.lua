return {
	-- 1. Gitsigns (Inline/Hunk management)
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 300,
			},
			current_line_blame_formatter = function(name, blame_info)
				local summary = blame_info.summary or ""
				if #summary > 40 then
					summary = summary:sub(1, 40) .. "..."
				end
				local author = blame_info.author == name and "You" or blame_info.author
				local when = require("gitsigns.util").get_relative_time(tonumber(blame_info.author_time))
				return {
					{ "      " .. author .. ", " .. when .. " - " .. summary, "GitSignsCurrentLineBlame" },
				}
			end,
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
				map("n", "]}", function()
					if vim.wo.diff then
						return "]}"
					end
					vim.schedule(function()
						gs.nav_hunk("next")
					end)
					return "<Ignore>"
				end, "Next Hunk")

				map("n", "[}", function()
					if vim.wo.diff then
						return "[}"
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
				map("n", "<leader>gtb", gs.toggle_current_line_blame, "Toggle Line Blame")
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
		branch = "refactor/v2", -- remove after 2026-11-16 when v2 lands on main
		dependencies = { "lewis6991/gitsigns.nvim" },
		event = "BufReadPost",
		config = function()
			require("scrollbar").setup({
				scrollbar = {
					visibility = "active",
					thumb = { highlight = "Visual" },
				},
				providers = { gitsigns = true },
				marks = {
					GitAdd    = { text = "▎" },
					GitChange = { text = "▎" },
					GitDelete = { text = "▸" },
				},
			})
		end,
	},

	-- 4. Neogit (Maybe move to fugitive?)
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
		opts = {
			integrations = { diffview = true },
			-- color diff hunks like source code instead of all-green / all-red
			treesitter_diff_highlight = true,
			word_diff_highlight = true,
			graph_style = "unicode",
		},
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
