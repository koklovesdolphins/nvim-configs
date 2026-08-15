return {
	-- {
	-- 	"projekt0n/github-nvim-theme",
	-- 	name = "github-theme",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("github-theme").setup({})
	-- 		vim.cmd("colorscheme github_dark_default")
	-- 		vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = "#e5c07b" })
	-- 	end,
	-- },
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 		vim.cmd("colorscheme tokyonight-night")
	-- 	end,
	-- },
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
        transparent = true,
			})
			vim.cmd("colorscheme kanagawa-wave")

			-- make search matches loud and easy to track
			-- vim.api.nvim_set_hl(0, "Search", { bg = "#ff9e3b", fg = "#1f1f28", bold = true })
			-- vim.api.nvim_set_hl(0, "IncSearch", { bg = "#ff9e3b", fg = "#1f1f28", bold = true })
			vim.api.nvim_set_hl(0, "CurSearch", { bg = "#ff9e3b", fg = "#1f1f28", bold = true })
		end,
	},
	-- show the file path at the top of each split (winbar breadcrumb)
	-- <leader>; picks a symbol to go to
  -- [; goes to the start of the current context
	-- do not set `vim.opt.winbar` anywhere: dropbar skips a window that already has one
	{
		"Bekaboo/dropbar.nvim",
		event = "VeryLazy",
		config = function()
			require("dropbar").setup({
				bar = {
					-- keep the bar off plugin windows and floats
					enable = function(buf, win, _)
						if
							not vim.api.nvim_buf_is_valid(buf)
							or not vim.api.nvim_win_is_valid(win)
							or vim.fn.win_gettype(win) ~= ""
							or vim.wo[win].winbar ~= ""
							or vim.bo[buf].buftype ~= ""
							or vim.api.nvim_win_get_config(win).relative ~= ""
						then
							return false
						end

						local skip = {
							["neo-tree"] = true,
							["noice"] = true,
							["lazy"] = true,
							["mason"] = true,
						}
						if skip[vim.bo[buf].filetype] then
							return false
						end

						-- a real file on disk, and not a huge one
						return vim.bo[buf].buflisted and vim.api.nvim_buf_get_name(buf) ~= ""
					end,
				},
			})

			local api = require("dropbar.api")
			vim.keymap.set("n", "<leader>;", api.pick, { desc = "Pick symbol in winbar" })
			vim.keymap.set("n", "[;", api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", api.select_next_context, { desc = "Select next context" })
		end,
	},
	-- show bottom line
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "wombat",
				},
				sections = {
					lualine_c = {
						{
							"filename",
							file_status = true, -- Displays file status (readonly, modified)
							newfile_status = false, -- Display new file status
							path = 1, -- 0: Just filename, 1: Relative path, 2: Absolute path
							shorting_target = 40, -- Shortens path if window is small
							symbols = {
								modified = "[+]",
								readonly = "[-]",
								unnamed = "[No Name]",
								newfile = "[New]",
							},
						},
					},
				},
			})
		end,
	},
	-- show indent
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				enabled = true,
				show_start = false,
				show_end = false,
			},
		},
		config = function(_, opts)
			-- This hook ensures the highlight is applied even if you change themes
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				-- Change these hex codes to match your background for lower contrast
				vim.api.nvim_set_hl(0, "IblIndent", { fg = "#1e2030" })
				vim.api.nvim_set_hl(0, "IblScope", { fg = "#4a506a" })
			end)

			require("ibl").setup(opts)
		end,
	},
	-- show commandline
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})

			-- colour the "[N/M]" search match counter to match the current-match highlight
			vim.api.nvim_set_hl(0, "NoiceVirtualText", { fg = "#ed2828", bold = true })
		end,
	},
}
