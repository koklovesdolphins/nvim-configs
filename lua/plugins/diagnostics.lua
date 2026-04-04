vim.keymap.set("n", "<leader>ie", function()
	vim.diagnostic.open_float()
end, { noremap = true, silent = true, desc = "Show line diagnostics" })

return {
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
			{ "<leader>iX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics everywhere" },
			{ "<leader>ix", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics" },
			{ "<leader>is", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols" },
			{
				"<leader>iS",
				"<cmd>Trouble lsp toggle<cr>",
				desc = "LSP references/definitions/...",
			},
			{ "<leader>il", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
			{ "<leader>iq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},
}
