return {
    'https://gitlab.com/code-stats/code-stats-vim/',
    init = function()
        vim.g.codestats_api_key = os.getenv("CODESTATSAPI")
    end,
}
