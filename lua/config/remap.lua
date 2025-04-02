vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fw", vim.cmd.Ex, { desc = "File View" })

-- CTRL+W + tab movement -> CTRL + tab movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Clear search highlighting
vim.keymap.set("n", "<Esc>", ":noh<CR>")

-- Split resizing
vim.keymap.set("n", "<C-Left>", "<C-w><")
vim.keymap.set("n", "<C-Up>", "<C-w>-")
vim.keymap.set("n", "<C-Right>", "<C-w>>")
vim.keymap.set("n", "<C-Down>", "<C-w>+")


-- diagnostic keybinds
vim.diagnostic.config({ virtual_lines = true })
vim.keymap.set("n", "<leader>e", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Show detailed errors" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })


vim.keymap.set("n", "<leader>tt", ":TodoTelescope<CR>", { desc = "TodoTelescope" })
vim.keymap.set("n", "<leader>tl", ":TodoLocList<CR>", { desc = "TodoLocList" })
