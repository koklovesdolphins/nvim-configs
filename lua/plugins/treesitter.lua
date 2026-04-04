return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install("stable")

			-- incase tree-sitter does load well. :TSInstall all
			vim.keymap.set("n", "<leader>th", vim.treesitter.start, { desc = "start treesitter" })
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = {
					"lua",
          "vim",
          "vimdoc",

					-- code
					"go",
					"gomod",
					"gosum",
					"gowork",
          "python",

					-- web/ui
					"html",
					"javascript",
					"javascriptreact",
          "jsx",
					"typescript",
					"typescriptreact",
          "tsx",
					"css",

					-- shell
          "bash",
					"make",

					-- note
          "markdown",
          "comment",

          -- others
          "gitcommit", 
          "dockerfile",
          "hcl",
          "terraform",
					"xml",
					"json",
					"toml",
					"yaml",
          "sql",
          "regex",
				},
				callback = function()
					vim.treesitter.start()
					-- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					-- vim.bo[0][0].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
