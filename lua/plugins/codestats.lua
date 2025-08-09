vim.pack.add({ { src = "https://gitlab.com/code-stats/code-stats-vim" } })
vim.g.codestats_api_key = os.getenv("CODESTATSAPI")
