return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			-- "ibhagwan/fzf-lua", -- optional
		},
		config = function()
			local git = require("neogit")
			local set_key = vim.keymap.set
			-- open using defaults
			set_key("n", "<leader>gn", git.open, { desc = "Open neogit." })
		end,
	},
}
