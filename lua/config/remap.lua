vim.keymap.set("n", "<leader>fw", vim.cmd.Ex, { desc = "File View" })

-- CTRL+W + split movement -> CTRL + split movement
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Swap to split left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Swap to split down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Swap to split up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Swap to split right" })

-- Clear search highlighting
vim.keymap.set("n", "<Esc>", ":noh<CR>")

-- Split resizing
vim.keymap.set("n", "<C-Left>", "<C-w><", { desc = "Resize split left" })
vim.keymap.set("n", "<C-Up>", "<C-w>-", { desc = "Resize split up" })
vim.keymap.set("n", "<C-Right>", "<C-w>>", { desc = "Resize split right" })
vim.keymap.set("n", "<C-Down>", "<C-w>+", { desc = "Resize split down" })

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

vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

vim.keymap.set("n", "<leader>pu", vim.pack.update, { desc = "[P]ack [U]pdate" })

local function trim(s)
    return s:match("^%s*(.*)"):match("(.-)%s*$")
end

vim.keymap.set("n", "<leader>ms", function()
    -- get current line : remove whitespace
    local line = trim(vim.api.nvim_get_current_line())

    local seperator = string.rep("-", 80 - string.len(line))
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))

    vim.api.nvim_buf_set_lines(0, row - 1, row, true, { line .. " " .. seperator })
end, { desc = "[M]ake [S]eperator" })
