-- tabs inserts 2 spaces
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.tabstop = 2        -- Number of spaces a tab counts for
vim.opt.softtabstop = 2    -- Number of spaces a tab counts for while editing
vim.opt.shiftwidth = 2     -- Number of spaces used for autoindent

vim.g.have_nerd_font = true
vim.g.mapleader = " "

-- show line numbers
vim.wo.number = true
-- vim.wo.relativenumber = true

-- use system clipboardd
vim.opt.clipboard = "unnamedplus"

-- Dedent in Insert Mode (instead of ctrl d or ctrl t)
vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Dedent line" })

-- in Visual Mode for blocks of code
vim.keymap.set("v", "<S-Tab>", "<", { desc = "Dedent selection" })
vim.keymap.set("v", "<Tab>", ">", { desc = "Indent selection" })
