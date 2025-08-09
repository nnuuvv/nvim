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


-- always show virtual_text, but only brief info
-- show virtual line for current_line
vim.diagnostic.config({
    virtual_text = {
        format = function(diagnostic)
            return string.match(diagnostic.message, "(.-)\n")
        end,
    },
    virtual_lines = {
        current_line = true
    }
})

-- diagnostic keybinds
vim.keymap.set("n", "<leader>ew", vim.diagnostic.open_float, { desc = "Open [E]rror [W]indow" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })


vim.keymap.set("n", "<leader>tt", ":TodoTelescope<CR>", { desc = "TodoTelescope" })
vim.keymap.set("n", "<leader>tl", ":TodoLocList<CR>", { desc = "TodoLocList" })

vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

vim.keymap.set("n", "<leader>pu", vim.pack.update, { desc = "[P]ack [U]pdate" })
