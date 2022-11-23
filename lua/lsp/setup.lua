-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local on_attach = require("lsp.lspconfig").on_attach
local capabilities = require("lsp.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = { "html", "cssls", "emmet_ls", "jsonls", "tsserver", "intelephense", }

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- for clangd setup
lspconfig.clangd.setup {
    cmd = {

        "clangd",

        "--background-index",

        "--suggest-missing-includes",

        "--clang-tidy",

    },
    on_attach = on_attach,
    capabilities = capabilities,

}


lspconfig.sumneko_lua.setup {
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
