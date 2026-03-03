-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
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
if not vim.lsp.config then
	vim.notify("vim.lsp.config not available - please update to Neovim 0.11+")
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
		"svlangserver",
		"html",
		"marksman",
		"omnisharp",
		"ltex",
		"ruff",
	},
	automatic_enable = {
		exclude = {
			-- "omnisharp",
			"clangd",
			"lua_ls",
			"svlangserver",
			"eslint",
			"pyright",
			"html",
			"marksman",
			"ltex",
			"gdscript",
		},
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
]]
--

-- local omnisharp_bin = "/home/cyl/.local/share/nvim/mason/bin/omnisharp-mono"
-- if not lspconfig.omnisharp_mono then
-- 	lspconfig.omnisharp_mono = {
-- 		default_config = {
-- 			cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
-- 			filetypes = { "cs" },
-- 			root_dir = lspconfig.util.root_pattern("*.csproj", "*.sln", ".git"),
-- 			settings = {},
-- 		},
-- 	}
-- end
local capabilities = require("lsp.lspconfig").capabilities
local on_attach = require("lsp.lspconfig").on_attach

-- local util = require 'lspconfig.util'
-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
vim.lsp.config.clangd = {
	cmd = {
		"clangd",
		"--background-index",
		"--suggest-missing-includes",
		"--clang-tidy",
		"--header-insertion=never",
	},
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	root_dir = function(fname)
		return vim.fs.root(fname, { ".git", "compile_commands.json", "Makefile", "CMakeLists.txt" })
			or vim.fs.dirname(fname)
	end,
}
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "lua" },
}

-- vim.lsp.config.eslint = {
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
-- 	root_dir = vim.fs.dirname,
-- }

local Pyright_cap = vim.deepcopy(capabilities)
Pyright_cap.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }

vim.lsp.config.pyright = {
	capabilities = Pyright_cap,
	on_attach = on_attach,
	settings = {
		pyright = {
			disableOrganizeImports = true, -- Using Ruff
		},
	},
	filetypes = { "python" },
}

-- HTML Language Server configuration
vim.lsp.config.html = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html" },
}

-- Marksman (Markdown) configuration
vim.lsp.config.marksman = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "markdown", "markdown.mdx" },
}

-- GDScript configuration
vim.lsp.config.gdscript = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "gdscript" },
}

-- OmniSharp (C#) configuration
-- Use omnisharp-mono for .NET Framework projects (ONI mods)
vim.lsp.config.omnisharp = {
	cmd = { "OmniSharp", "--languageserver" },
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "cs" },
	root_dir = function(fname)
		return vim.fs.root(fname, { "*.sln", "*.csproj", ".git" }) or vim.fs.dirname(fname)
	end,
	enable_roslyn_analyzers = true,
	organize_imports_on_format = true,
	enable_import_completion = true,
}

vim.lsp.enable({
	"gdscript",
	"marksman",
	"html",
	"pyright",
	"clangd",
	"lua_ls",
	"omnisharp",
})
