-- fzf-lua replaces rg_opts wholesale, so every copy must keep --max-columns and
-- the trailing -e. Without -e, a query that starts with - becomes an rg flag.
local RG_OPTS = "--hidden -g '!.git' -g '!.jj' --column --line-number "
	.. "--no-heading --color=always --smart-case --max-columns=4096 -e"

return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-mini/mini.icons" },
		init = function()
			-- ctrl-r flips the preview between below (vertical) and right (horizontal).
			-- keymap.builtin only accepts named actions, so this needs its own map.
			local function toggle_preview_layout()
				local win = require("fzf-lua.win").__SELF()
				if not win then
					return
				end
				local pos = win:normalize_preview_layout().pos
				win._preview_pos_force = (pos == "up" or pos == "down") and "right" or "down"
				if win.winopts.split or not win.previewer_is_builtin then
					win:SIGWINCH({ "toggle-preview-cw" })
				end
				win:redraw()
			end
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "fzf",
				callback = function(ev)
					vim.keymap.set("t", "<C-r>", toggle_preview_layout, { buffer = ev.buf, nowait = true })
				end,
			})
		end,
		opts = {
			-- fzf_bin = 'builtin',
			winopts = {
				-- Alt+shift+arrow to scroll on preview
        preview = {
					layout = "vertical", -- results on top, preview below
					vertical = "down:50%",
				},
			},
			-- applies to grep_cword, grep_visual and grep_curbuf
			grep = { rg_opts = RG_OPTS },
		},
		keys = {
			-- help
			{ "<leader>?", "<CMD>FzfLua keymaps<CR>", desc = "Key Maps" },
			{ "<leader>h", "<CMD>FzfLua help_tags<CR>", desc = "Help Pages" },
			{ '<leader>"', "<CMD>FzfLua commands<CR>", desc = "All Command" },
			{ "<leader>fr", "<CMD>FzfLua resume<CR>", desc = "Resume last picker" },

			-- search
			-- { "<leader>/", "<CMD>FzfLua grep_curbuf<CR>", desc = "Grep (Current Buffer)" }, -- default fuzzy
			{
				"<leader>/",
				function()
					require("fzf-lua").grep_curbuf({ fzf_opts = { ["--no-sort"] = "" } }) -- need --no-sort else fuzzy sorts occurance in file
				end,
				desc = "Grep (Current Buffer)",
			},
      -- for highlighting use /
      -- n and N to move around
      {
				"<leader>f/",
				function()
					require("fzf-lua").live_grep({
						fzf_opts = { ["--no-sort"] = "" },
						-- --sort path disables parallel search, so keep it on this map only
						rg_opts = "--sort path " .. RG_OPTS,
					})
				end,
				desc = "Grep (Current directory)",
			},
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
			{ "<leader>ggs", "<CMD>FzfLua git_status<CR>", desc = "Status" }, -- shows modified, stage and trackied files
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
