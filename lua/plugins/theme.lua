vim.pack.add({
    { src = "https://github.com/catppuccin/nvim",        name = "catppuccin" },
    { src = "https://github.com/EdenEast/nightfox.nvim", name = "nightfox" },
})

local get_time_of_day = function()
    local hour = tonumber(os.date("%H"))
    if hour >= 6 and hour < 12 then
        -- morning
        return "dayfox"
    elseif hour >= 12 and hour < 18 then
        -- afternoon
        return "dayfox"
    elseif hour >= 18 and hour < 24 then
        -- evening
        return "catppuccin-mocha"
    else
        -- night
        return "catppuccin-mocha"
    end
end

vim.cmd("colorscheme " .. get_time_of_day())
