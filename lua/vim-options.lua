-- tabs inserts 2 spaces
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 2 -- Number of spaces a tab counts for
vim.opt.softtabstop = 2 -- Number of spaces a tab counts for while editing
vim.opt.shiftwidth = 2 -- Number of spaces used for autoindent

vim.g.have_nerd_font = true
vim.g.mapleader = " "

-- show line numbers
vim.wo.number = true
vim.opt.relativenumber = false

-- use system clipboardd
vim.opt.clipboard = "unnamedplus"

-- Dedent in Insert Mode (instead of ctrl d or ctrl t)
vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Dedent line" })

-- in Visual Mode for blocks of code
vim.keymap.set("v", "<S-Tab>", "<", { desc = "Dedent selection" })
vim.keymap.set("v", "<Tab>", ">", { desc = "Indent selection" })

-- MISC shortcuts
vim.keymap.set("n", "<leader>qt", "<cmd>w<CR>:tabclose<CR>", { desc = "Save and close tab" })
vim.keymap.set({ "n", "i" }, "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>qs", "<cmd>w<CR><C-w>c", { desc = "Save and close split" })

-- allows backspace, space, left, right
-- to navigate in normal/visual/insert/replace mode
vim.opt.whichwrap = "b,s,<,>,[,]"

-- open splits to the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true
