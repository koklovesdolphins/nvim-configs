return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-mini/mini.icons" },
		opts = {},
		keys = {
			-- help
			{ "<leader>?", "<CMD>FzfLua keymaps<CR>", desc = "Key Maps" },
			{ "<leader>h", "<CMD>FzfLua help_tags<CR>", desc = "Help Pages" },
			{ '<leader>"', "<CMD>FzfLua commands<CR>", desc = "All Command" },
			{ "<leader>fr", "<CMD>FzfLua resume<CR>", desc = "Resume last picker" },

			-- search
			{ "<leader>/", "<CMD>FzfLua grep_curbuf<CR>", desc = "Grep (Current Buffer)" }, -- default fuzzy
			{ "<leader>f/", "<CMD>FzfLua live_grep<CR>", desc = "Grep (Current directory)" }, -- default regex
			{ "<leader>fw", "<CMD>FzfLua grep_cword<CR>", desc = "Grep word under cursor (Current directory)" },
			{ "<leader>fv", "<CMD>FzfLua grep_visual<CR>", desc = "Grep Selection (Current directory)", mode = "v" },

			-- find files
			{ "<leader>ff", "<CMD>FzfLua files<CR>", desc = "Files (Root Dir)" },
			{ "<leader>fg", "<CMD>FzfLua git_files<CR>", desc = "Files (git tracked files)" }, -- doesnt show untracked
			{ "<leader>fb", "<CMD>FzfLua buffers sort_mru=true sort_lastused=true<CR>", desc = "Buffers" }, -- jump between recent files
			{ "<leader>fo", "<CMD>FzfLua oldfiles<CR>", desc = "Old files" }, -- closed files

			-- misc
			{ "<leader>fc", "<CMD>FzfLua command_history<CR>", desc = "Neovim Command History" },
			{ "<leader>:", "<CMD>FzfLua registers<CR>", desc = "Registers" }, -- clipboard, etc

			-- git
			{ "<leader>ggs", "<CMD>FzfLua git_status<CR>", desc = "Status" },
			{ "<leader>ggc", "<CMD>FzfLua git_commits<CR>", desc = "Commits" },
			{ "<leader>ggh", "<CMD>FzfLua git_bcommits<CR>", desc = "File history" },

			-- Goto
			-- { "<leader>gd", "<CMD>FzfLua diagnostics_document<CR>", desc = "Diagnostics (Document)" },
			-- { "<leader>gD", "<CMD>FzfLua diagnostics_workspace<CR>", desc = "Diagnostics (Workspace)" },
			-- { "<leader>gj", "<CMD>FzfLua jumps<CR>", desc = "Jumplist" },
			-- { "<leader>gl", "<CMD>FzfLua loclist<CR>", desc = "Location List" },
			-- { "<leader>gm", "<CMD>FzfLua marks<CR>", desc = "Jump to Mark" },
			-- { "<leader>gq", "<CMD>FzfLua quickfix<CR>", desc = "Quickfix List" },
			-- {
			-- 	"<leader>gs",
			-- 	function()
			-- 		require("fzf-lua").lsp_document_symbols({})
			-- 	end,
			-- 	desc = "Goto Symbol (Document)",
			-- },

			-- lsp_references
			-- lsp_definitions
			-- lsp_code_actions
		},
	},
}
