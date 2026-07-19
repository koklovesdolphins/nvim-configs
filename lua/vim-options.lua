-- tabs inserts 2 spaces
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 2 -- Number of spaces a tab counts for
vim.opt.softtabstop = 2 -- Number of spaces a tab counts for while editing
vim.opt.shiftwidth = 2 -- Number of spaces used for autoindent

vim.g.have_nerd_font = true
vim.g.mapleader = " "

-- prevent lag on arrow keys in insert mode
vim.opt.ttimeoutlen = 10

-- show line numbers
vim.wo.number = true
vim.opt.relativenumber = false

-- use system clipboardd
vim.opt.clipboard = "unnamedplus"

-- reload buffer automatically when the file changes on disk (e.g. AI agent writes)
vim.opt.autoread = true

-- lower from the 4000ms default so CursorHold (reload/gitsigns) fires promptly
vim.opt.updatetime = 300

-- Dedent in Insert Mode (instead of ctrl d or ctrl t)
vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Dedent line" })

-- in Visual Mode for blocks of code
vim.keymap.set("v", "<S-Tab>", "<", { desc = "Dedent selection" })
vim.keymap.set("v", "<Tab>", ">", { desc = "Indent selection" })

-- MISC shortcuts
vim.keymap.set("n", "<leader>qt", "<cmd>w<CR>:tabclose<CR>", { desc = "Save and close tab" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>qs", "<cmd>w<CR><C-w>c", { desc = "Save and close split" })

-- allows backspace, space, left, right
-- to navigate in normal/visual/insert/replace mode
vim.opt.whichwrap = "b,s,<,>,[,]"

-- Move cursor down/up by 20 lines without scrolling the screen
vim.keymap.set('n', '<C-d>', '20j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '20k', { noremap = true, silent = true })

-- Scroll the screen down/up by 5 lines
vim.keymap.set('n', '<C-e>', '5<C-e>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-y>', '5<C-y>', { noremap = true, silent = true })

-- open splits to the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- remap Ctrl+Z to undo (prevents terminal suspend)
vim.keymap.set("n", "<C-z>", "u", { desc = "Undo" })
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo" })

-- undo
vim.opt.undofile = true -- persist undo history across file closes
vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")
vim.keymap.set("i", "!", "!<C-g>u")
vim.keymap.set("i", "?", "?<C-g>u")
vim.keymap.set("i", "<CR>", "<CR><C-g>u") -- add undo breaks during enter

-- some helpers
-- :messages - to see output/error messages

-- actively check for file changes on disk, since `autoread` alone is passive
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	command = "checktime",
})

-- announce when a buffer got silently reloaded from disk
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})

-- manual reload-from-disk, in case you don't want to wait for the autocmd above
vim.keymap.set("n", "<leader>rl", "<cmd>checktime<CR>", { desc = "Reload buffer from disk" })
