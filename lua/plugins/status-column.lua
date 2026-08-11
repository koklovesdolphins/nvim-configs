return {
	-- diagnostics
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = {
			modes = {
				lsp = {
					win = { position = "right" },
				},
			},
		},
		keys = {
			{ "<leader>xv", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble Panel)" },
			{
				"<leader>xx",
				function()
					local config = vim.diagnostic.config()
					vim.diagnostic.config({
						virtual_text = not config.virtual_text,
					})
				end,
				desc = "Toggle Inline Diagnostics (Virtual Text)",
			},
		},
		init = function()
			-- custom icons in status-column
			local icons = {
				Error = "", -- Circle with an X
				Warn = "", -- Triangle with an !
				Hint = "󰌵", -- Lightbulb
				Info = "", -- Circle with an i
			}

			vim.diagnostic.config({
				virtual_text = false,
				underline = true,
				update_in_insert = true, -- show while typing
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.Error,
						[vim.diagnostic.severity.WARN] = icons.Warn,
						[vim.diagnostic.severity.HINT] = icons.Hint,
						[vim.diagnostic.severity.INFO] = icons.Info,
					},
				},
			})
		end,
	},
	-- open or collapse blocks using tree-sitter
	-- za - toggle open/close, zc close, zo open, zM close all, zR open all
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			-- statuscol.nvim draws this column, so you can click a marker to fold
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99 -- UFO needs a higher foldlevel to start open
			vim.o.foldlevelstart = 99 -- UFO needs a higher foldlevel to start open
			vim.o.foldenable = true

			-- triangles instead of the default `-` and `+`.
			-- foldsep is blank, so no vertical bar runs down an open fold
			vim.opt.fillchars:append({ foldopen = "▾", foldclose = "▸", foldsep = " " })

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" } -- tree-sitter should be more reliable
				end,
			})
		end,
	},
	-- builds the status column, so the git bar sits next to the code (like VSCode)
	-- neovim always draws its own sign column left of the numbers, hence this plugin
	{
		"luukvbaal/statuscol.nvim",
		lazy = false,
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				setopt = true,
				-- leave plugin windows alone, they draw their own gutters
				ft_ignore = { "oil", "neo-tree", "NeogitStatus", "trouble", "lazy", "help" },
				bt_ignore = { "terminal", "nofile" },
				-- `auto = false` keeps every segment drawn on lines without a sign,
				-- so the width stays fixed and the text never shifts while typing
				segments = {
					-- 1. fold markers, far left. click one to fold or unfold
					{
						text = { builtin.foldfunc },
						click = "v:lua.ScFa",
					},
					-- 2. diagnostics
					-- namespaces are lua patterns. neovim 0.11 names them
					-- `nvim.<client>.diagnostic.signs`, so match the tail only
					{
						sign = { namespace = { "diagnostic%.signs" }, maxwidth = 1, colwidth = 1, auto = false },
						click = "v:lua.ScSa",
					},
					-- 3. line number
					{
						text = { builtin.lnumfunc, " " },
						click = "v:lua.ScLa",
					},
					-- 4. git hunks, directly against the code
					{
						-- matches `gitsigns_signs_` and `gitsigns_signs_staged`,
						-- but not `gitsigns_blame` or `gitsigns_removed`
						sign = { namespace = { "gitsigns_signs" }, maxwidth = 1, colwidth = 1, auto = false, wrap = true },
						click = "v:lua.ScSa",
					},
				},
			})
		end,
	},
}
