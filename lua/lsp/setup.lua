-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local util = require 'lspconfig.util'
local status, mason = pcall(require, "mason")
if not status then
    vim.notify("Can't find mason")
    return
end

local status, mason_config = pcall(require, "mason-lspconfig")
if not status then
    vim.notify("Can't find mason-lspconfig")
    return
end

local status, lspconfig = pcall(require, "lspconfig")
if not status then
    vim.notify("没有找到 lspconfig")
    return
end


mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

mason_config.setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "clangd",
        "cmake",
        "svlangserver",
        "html",
        "marksman",
        "omnisharp"
    },
})

--[[
local servers = {
    sumneko_lua = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
    clangd = require("lsp.config.clangd"),
}

for name, config in pairs(servers) do
    if config ~= nil and type(config) == "table" then
        -- 自定义初始化配置文件必须实现on_setup 方法
        config.on_setup(lspconfig[name])
        -- vim.notify(name.." init with customized config")
    else
        -- 使用默认参数
        lspconfig[name].setup({})
        vim.notify("init with default config")
    end
end
]]--

local capabilities = require("lsp.lspconfig").capabilities
local on_attach = require("lsp.lspconfig").on_attach

-- local util = require 'lspconfig.util'
-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
lspconfig.clangd.setup{
    cmd = {

        "clangd",

        "--background-index",

        "--suggest-missing-includes",

        "--clang-tidy",

    },
    on_attach = on_attach,
    capabilities = capabilities,
}


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.lua_ls.setup{
    settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.svlangserver.setup{
    -- https://github.com/imc-trading/svlangserver
    on_init = function(client)
        local path = client.workspace_folders[1].name

        if path == '/path/to/project1' then
        client.config.settings.systemverilog = {
            includeIndexing     = {"**/*.{sv,svh}"},
            excludeIndexing     = {"test/**/*.sv*"},
            defines             = {},
            launchConfiguration = "/tools/verilator -sv -Wall --lint-only",
            formatCommand       = "/tools/verible-verilog-format"
        }
        elseif path == '/path/to/project2' then
        client.config.settings.systemverilog = {
            includeIndexing     = {"**/*.{sv,svh}"},
            excludeIndexing     = {"sim/**/*.sv*"},
            defines             = {},
            launchConfiguration = "/tools/verilator -sv -Wall --lint-only",
            formatCommand       = "/tools/verible-verilog-format"
        }
        end

        client.notify("workspace/didChangeConfiguration")
        return true
    end,
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.pyright.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.html.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.marksman.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.omnisharp.setup {
    cmd = { "dotnet", "/home/cyl/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },

    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = true,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = false,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,
    capabilities = capabilities,
    on_attach = on_attach,
}

