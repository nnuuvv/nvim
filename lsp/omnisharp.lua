local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1

local omnisharp_path = ""
if is_windows then
    omnisharp_path = vim.fs.normalize("~/omnisharp/OmniSharp.exe")
else
    omnisharp_path = vim.fs.normalize("~/omnisharp/OmniSharp")
end

return {
    cmd = { omnisharp_path, '--languageserver' },
    filetypes = { 'cs', 'razor' },
    root_dir = { '.sln', 'Directory.Build.props', '.git' },
    settings = {
        FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
        },
        MsBuild = {
            LoadProjectsOnDemand = nil,
        },
        RoslynExtensionsOptions = {
            EnableImportCompletion = true,
            AnalyzeOpenDocumentsOnly = nil,
        },
        Sdk = {
            IncludePrereleases = true,
        },
    },
}
