return {
    cmd = { "lua-language-server" },
    root_markers = {".luarc.json", ".luarc.jsonc"},
    filetypes = {"lua"},
    settings = {
        Lua = {
            telemetry = {
                enabled = false
            }
        }
    }
}
