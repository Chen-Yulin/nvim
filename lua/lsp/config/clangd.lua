local util = require 'lspconfig.util'
local lspconfig = require("lsp.lspconfig")
local capabilities = require("lsp.lspconfig").capabilities

-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader

local opts = {
    cmd = {

        "clangd",

        "--background-index",

        "--suggest-missing-includes",

        "--clang-tidy",

    },
    on_attach = function(client, bufnr)
        lspconfig.disableFormat(client)
        lspconfig.keyAttach(bufnr)
    end,
    capabilities = capabilities,
}

return {
    on_setup = function(server)
        server:setup(opts)
    end,
}
