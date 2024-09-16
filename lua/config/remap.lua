vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- CTRL+W + tab movement -> CTRL + tab movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Clear search highlighting
vim.keymap.set("n", "<leader>/", ":noh")

-- Split resizing
vim.keymap.set("n", "<C-Left>", "<C-w><")
vim.keymap.set("n", "<C-Up>", "<C-w>-")
vim.keymap.set("n", "<C-Right>", "<C-w>>")
vim.keymap.set("n", "<C-Down>", "<C-w>+")

