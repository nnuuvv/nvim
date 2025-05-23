require("config")

vim.api.nvim_create_user_command(
    'AddPlugin',
    function(input)
        local repo = input.fargs
        local url = 'https://github.com/%s/%s.git'
        -- relative to the config dir
        local plugin_dir = "./pack/start/%s"

        -- print(plugin_dir)

        if repo[1] == nil or repo[2] == nil then
            local msg = "must provide user name and repository"
            vim.notify(msg, vim.log.levels.WARN)
            return
        end

        -- print(plugin_dir:format(repo[2]))

        local full_url = url:format(repo[1], repo[2])

        local on_done = function()
            vim.cmd('packloadall! | helptags ALL')
            vim.notify("Done.")
        end

        local command =
            table.concat({ "git", "submodule", "add", full_url, plugin_dir:format(repo[2]) }, " ")
            .. ";" .. table.concat({ "git", "submodule", "init", plugin_dir:format(repo[2]) }, " ")
            .. ";" .. table.concat({ "git", "submodule", "update", plugin_dir:format(repo[2]) }, " ")
            .. ";" .. table.concat({ "git", "add", plugin_dir:format(repo[2]) }, " ")
            .. ";" .. table.concat({ "git", "add", ".gitmodules" }, " ")
            .. ";" .. table.concat({ "git", "commit", "-m", "Added plugin", repo[2], "as submodule" }, " ")

        vim.notify("Adding submodule...")
        vim.notify("Initializing submodule...")
        vim.notify("Updating submodule...")
        vim.notify("Adding to git...")
        vim.notify("Committing...")
        vim.fn.jobstart(command, {
            on_exit = on_done,
            cwd = vim.fn.stdpath("config")
        })
    end,
    { nargs = '+' }
)

vim.api.nvim_create_user_command(
    'RemovePlugin',
    function(input)
        local repo = input.fargs
        -- relative to the config dir
        local plugin_dir = "./pack/start/%s"
        local module_dir = "./.git/modules/pack/start/%s"

        -- print(plugin_dir)

        if repo[1] == nil then
            local msg = "must provide plugin name"
            vim.notify(msg, vim.log.levels.WARN)
            return
        end

        local on_done = function()
            vim.cmd('packloadall! | helptags ALL')
            vim.notify("Done.")
        end


        local command =
            table.concat({ "git", "submodule", "deinit", "-f", plugin_dir:format(repo[1]) }, " ")
            .. ";" .. table.concat({ "git", "rm", plugin_dir:format(repo[1]) }, " ")
            .. ";" .. table.concat({ "rm", "-rf", plugin_dir:format(repo[1]) }, " ")
            .. ";" .. table.concat({ "rm", "-rf", module_dir:format(repo[1]) }, " ")
            .. ";" .. table.concat({ "sed", "-i", "/" .. repo[1] .. "/d", ".gitmodules" }, " ")
            .. ";" .. table.concat({ "git", "add", plugin_dir:format(repo[1]) }, " ")
            .. ";" .. table.concat({ "git", "add", ".gitmodules" }, " ")
            .. ";" .. table.concat({ "git", "commit", "-m", "Removed plugin", repo[2], "submodule" }, " ")

        vim.notify("Deinitting submodule...")
        vim.notify("Removing submodule dir from git...")
        vim.notify("Removing submodule folder...")
        vim.notify("Removing .gitmodules entry...")
        vim.notify("Updating git...")
        vim.notify("Committing...")
        vim.fn.jobstart(command, {
            on_exit = on_done,
            cwd = vim.fn.stdpath("config")
        })
    end,
    { nargs = '+' }
)

vim.api.nvim_create_user_command(
    'UpdatePlugins',
    function()
        local command =
            table.concat({ "git", "submodule", "update" }, " ")
            .. ";" .. table.concat({ "git", "add", "./.gitmodules" }, " ")
            .. ";" .. table.concat({ "git", "commit", "-m", "Updated plugin submodules" }, " ")

        local on_done = function()
            vim.cmd('packloadall! | helptags ALL')
            vim.notify("Done.")
        end

        vim.notify("Updating all submodules...")
        vim.notify("Updating git")
        vim.fn.jobstart(command, {
            on_exit = on_done,
            cwd = vim.fn.stdpath("config")
        })
    end,
    { nargs = '+' }
)
