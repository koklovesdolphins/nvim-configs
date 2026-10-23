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

			-- neogit inline diffs: tint the background, keep the text readable
			local function neogit_diff_hl()
				local fg = "#dcd7ba"
				local hl = {
					NeogitDiffAdd = { fg = fg, bg = "#2b3328" },
					NeogitDiffAddHighlight = { fg = fg, bg = "#3a462f" },
					NeogitDiffDelete = { fg = fg, bg = "#43242b" },
					NeogitDiffDeleteHighlight = { fg = fg, bg = "#5a2f38" },
					NeogitDiffContext = { fg = fg, bg = "NONE" },
					NeogitDiffContextHighlight = { fg = fg, bg = "#2a2a37" },
					NeogitHunkHeader = { fg = "#7e9cd8", bg = "#252535" },
					NeogitHunkHeaderHighlight = { fg = "#7e9cd8", bg = "#2a2a37", bold = true },
				}
				for group, opts in pairs(hl) do
					vim.api.nvim_set_hl(0, group, opts)
				end
			end

			neogit_diff_hl()
			vim.api.nvim_create_autocmd("ColorScheme", { callback = neogit_diff_hl })
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
			-- bold mode block, from the kanagawa lualine theme
			vim.g.kanagawa_lualine_bold = true

			-- the name that git records as the author of your own commits
			vim.system({ "git", "config", "user.name" }, { text = true }, function(out)
				vim.g.lualine_git_user = vim.trim(out.stdout or "")
			end)

			-- `git log` is too slow for every redraw, so cache the result per buffer
			local function cache_last_commit(buf)
				local name = vim.api.nvim_buf_get_name(buf)
				if name == "" or vim.bo[buf].buftype ~= "" then
					return
				end
				vim.system({
					"git",
					"-C",
					vim.fn.fnamemodify(name, ":h"),
					"log",
					"-1",
					"--format=%an\t%ar",
					"--",
					name,
				}, { text = true }, function(out)
					local author, when = vim.trim(out.stdout or ""):match("^(.-)\t(.*)$")
					local line = ""
					if author then
						-- match the gitsigns blame line, which says "You"
						if author == vim.g.lualine_git_user then
							author = "You"
						end
						line = author .. ", " .. when
					end
					vim.schedule(function()
						if not vim.api.nvim_buf_is_valid(buf) then
							return
						end
						vim.b[buf].lualine_last_commit = line ~= "" and line or nil
						vim.cmd("redrawstatus")
					end)
				end)
			end

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
				group = vim.api.nvim_create_augroup("LualineLastCommit", { clear = true }),
				callback = function(args)
					cache_last_commit(args.buf)
				end,
			})
			require("lualine").setup({
				options = {
					theme = "kanagawa",
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
				},
				sections = {
					lualine_c = {
						{
							-- current working directory, shortened with ~
							function()
								return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
							end,
							-- carpYellow reads clearly on the section background
							color = { fg = "#c0a36e", gui = "bold" },
							separator = "│",
						},
						{
							"filename",
							file_status = true, -- Displays file status (readonly, modified)
							newfile_status = false, -- Display new file status
							path = 1, -- 0: Just filename, 1: Relative path, 2: Absolute path
							shorting_target = 40, -- Shortens path if window is small
							symbols = {
								modified = "[+]",
								readonly = "[-]",
								unnamed = "",
								newfile = "[New]",
							},
						},
						{
							-- errors, warnings and hints from the language server
							"diagnostics",
							sources = { "nvim_lsp" },
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
						},
					},
					lualine_x = {
						{
							-- size of the visual selection: chars, or lines x chars
							function()
								local mode = vim.fn.mode()
								if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
									return ""
								end
								local s_line, s_col = vim.fn.line("v"), vim.fn.col("v")
								local e_line, e_col = vim.fn.line("."), vim.fn.col(".")
								local lines = math.abs(e_line - s_line) + 1
								if mode == "V" then
									return lines .. " lines"
								end
								if mode == "\22" then
									return lines .. "x" .. (math.abs(e_col - s_col) + 1)
								end
								return vim.fn.wordcount().visual_chars .. " chars"
							end,
							color = { fg = "#ff9e3b", gui = "bold" },
						},
						{
							-- last commit that touched this file, from the cache below
							function()
								return vim.b.lualine_last_commit or ""
							end,
						},
						"filetype",
					},
					lualine_y = {
						-- compact: the defaults pad these to a fixed width
						{ "%p%%", padding = { left = 1, right = 0 } },
						{ "%l:%c", padding = { left = 1, right = 1 } },
					},
					lualine_z = {
						{
							-- clock, 24 hour
							function()
								return " " .. os.date("%H:%M")
							end,
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
