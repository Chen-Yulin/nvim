-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local util = require 'lspconfig.util'
local masonStatus, mason = pcall(require, "mason")
if not masonStatus then
    vim.notify("Can't find mason")
    return
end

local masonconfigStatus, mason_config = pcall(require, "mason-lspconfig")
if not masonconfigStatus then
    vim.notify("Can't find mason-lspconfig")
    return
end

local lspconfigStatus, lspconfig = pcall(require, "lspconfig")
if not lspconfigStatus then
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
        "omnisharp",
        "ltex"
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

        "--header-insertion=never",

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
--lspconfig.ltex.setup{
--    capabilities = capabilities,
--    on_attach = on_attach,
--}
lspconfig.csharp_ls.setup{
    cmd = { "csharp-ls" },
    filetypes = {"cs"},
    init_options = {
        AutomaticWorkspaceInit = true
    },
    capabilities = capabilities,
    on_attach = on_attach,
}
