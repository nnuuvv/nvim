vim.pack.add({
    { src = "https://github.com/catppuccin/nvim",        name = "catppuccin" },
    { src = "https://github.com/EdenEast/nightfox.nvim", name = "nightfox" },
})

local get_time_of_day = function()
    local hour = tonumber(os.date("%H"))
    if hour < 19 then
        -- day
        return "dayfox"
    else
        -- night
        return "catppuccin-mocha"
    end
end

vim.cmd("colorscheme " .. get_time_of_day())
