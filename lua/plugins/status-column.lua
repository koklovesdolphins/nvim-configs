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
				Error = " ", -- Circle with an X
				Warn = " ", -- Triangle with an !
				Hint = "󰌵 ", -- Lightbulb
				Info = " ", -- Circle with an i
			}

			vim.diagnostic.config({
				virtual_text = false,
				-- signs = true,
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
			vim.o.foldcolumn = "0" -- just hide column (the relative number issue too problematic)
			vim.o.foldlevel = 99 -- UFO needs a higher foldlevel to start open
			vim.o.foldlevelstart = 99 -- UFO needs a higher foldlevel to start open
			vim.o.foldenable = true

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" } -- tree-sitter should be more reliable
				end,
			})
		end,
	},
	-- shows status column
	-- {
	-- 	"luukvbaal/statuscol.nvim",
	-- 	config = function()
	-- 		local builtin = require("statuscol.builtin")
	-- 		require("statuscol").setup({
	-- 			relculright = true,
	-- 			setopt = true,
	-- 			segments = {
	-- 				-- Fold Column (UFO)
	-- 				{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
	-- 				-- Sign Column (Git & Diagnostics)
	-- 				{ sign = { "%s" }, click = "v:lua.ScSa" },
	-- 				-- Line Numbers
	-- 				{
	-- 					text = { builtin.lnumfunc, " " },
	-- 					condition = { true, builtin.not_empty },
	-- 					click = "v:lua.ScLa",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
