local ensure_installed = {
	"lua_ls",
	"gopls",
	"pyright",
	"ruff",
	"ts_ls",
	"html",
	"cssls",
	"terraformls",
	"dockerls",
	"bashls",
}
return {
	{
		"Saghen/blink.cmp",
		version = "v1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		opts = {
			keymap = { preset = "default" },
			completion = {
				menu = {
					-- Delay the completion menu from popping up (in milliseconds)
					auto_show_delay_ms = 1000,
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"Saghen/blink.cmp",
		},
		config = function()
			-- Setup Mason to manage your binaries
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
			})

			-- Get capabilities for auto-completion (from blink.cmp)
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local servers = ensure_installed

			for _, server in ipairs(servers) do
				vim.lsp.config(server, {
					capabilities = capabilities,
				})
			end

			-- Custom logic for Lua (to recognize 'vim' global)
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = { diagnostics = { globals = { "vim" } } },
				},
			})
			vim.lsp.enable(vim.list_extend({ "lua_ls" }, servers))

			-- TODO see what are these
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})
		end,
	},
}
