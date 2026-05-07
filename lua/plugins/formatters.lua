local prettier = { "prettierd", "prettier", stop_after_first = true }

local ignore_format_on_save = { markdown = true }

return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"prettierd",
				"prettier",
				"stylua",
				"gofumpt",
				"goimports",
				"shfmt",
				"taplo",
				"sql-formatter",
			},
		},
	},
	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>fmt",
				function()
					require("conform").format({ force = true })
				end,
				desc = "Force format",
			},
		},
		opts = {
			formatters_by_ft = {
				-- lua
				lua = { "stylua" },
				-- web
				javascript = prettier,
				typescript = prettier,
				javascriptreact = prettier,
				typescriptreact = prettier,
				html = prettier,
				css = prettier,
				scss = prettier,
				-- code
				python = { "ruff_organize_imports", "ruff_format" },
				go = { "goimports", "gofumpt" },
				-- shell
				sh = { "shfmt" },
				-- note
				markdown = prettier,
				-- data/config
				yaml = prettier,
				toml = { "taplo" },
				json = prettier,
				sql = { "sql_formatter" },
			},
			format_on_save = function(bufnr)
				if ignore_format_on_save[vim.bo[bufnr].filetype] then
					return nil
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
		},
	},
}
