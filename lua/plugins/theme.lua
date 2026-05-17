return {
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- Load this during startup
		priority = 1000, -- Load this before other plugins
		config = function()
			require("github-theme").setup({})
			vim.cmd("colorscheme github_dark_default")
			vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = "#e5c07b" })
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
		end,
	},
}
