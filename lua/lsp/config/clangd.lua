-- local util = require 'lspconfig.util'
local on_attach = require("lsp.lspconfig").on_attach
local capabilities = require("lsp.lspconfig").capabilities

-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader

local opts = {
    cmd = {

        "clangd",

        "--background-index",

        "--suggest-missing-includes",

        "--clang-tidy",

    },
    -- on_attach = function(client, bufnr)
        --lspconfig.disableFormat(client)
        --lspconfig.keyAttach(bufnr)
    -- end,
    on_attach = on_attach,
    capabilities = capabilities,
}

return {
    on_setup = function(server)
        server:setup(opts)
    end,
}
