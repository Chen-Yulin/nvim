-- map leader

vim.g.mapleader = " "
vim.g.maplocalleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- tokyonight
	"folke/tokyonight.nvim",
	"sainnhe/sonokai",
	-- OceanicNext
	-- "mhartington/oceanic-next",
	-- gruvbox
	-- { "ellisonleao/gruvbox.nvim", dependencies = { "rktjmp/lush.nvim" } },
	-- zephyr 暂时不推荐，详见上边解释
	-- "glepnir/zephyr-nvim",
	-- nord
	-- "shaunsingh/nord.nvim",
	-- onedark
	-- "ful1e5/onedark.nvim",
	-- nightfox
	-- "EdenEast/nightfox.nvim",
	-- nvim-tree
	{ "kyazdani42/nvim-tree.lua", dependencies = "kyazdani42/nvim-web-devicons" },
	-- bufferline
	{ "akinsho/bufferline.nvim", dependencies = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } },

	-- lualine
	{ "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },
	"arkav/lualine-lsp-progress",
	--telescope
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

	-- treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	--------------------- LSP --------------------
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	-- Lspconfig
	{ "neovim/nvim-lspconfig" },
	-- 补全引擎
	"hrsh7th/nvim-cmp",
	-- snippet 引擎
	"hrsh7th/vim-vsnip",
	-- 补全源
	"hrsh7th/cmp-vsnip",
	"hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
	"hrsh7th/cmp-buffer", -- { name = 'buffer' },
	"hrsh7th/cmp-path", -- { name = 'path' }
	"hrsh7th/cmp-cmdline", -- { name = 'cmdline' }

	-- 常见编程语言代码段
	"rafamadriz/friendly-snippets",
	"SirVer/ultisnips",

	-- ui
	"onsails/lspkind-nvim",
	-- indent-blankline
	"lukas-reineke/indent-blankline.nvim",
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},

	-- dap
	"mfussenegger/nvim-dap",
	"theHamsta/nvim-dap-virtual-text",
	"rcarriga/nvim-dap-ui",
	"ravenxrz/DAPInstall.nvim",

	"voldikss/vim-floaterm",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	"Civitasv/cmake-tools.nvim",
	"Chen-Yulin/transparent.nvim",
	"ggandor/leap.nvim",
	"Chen-Yulin/dashboard-nvim",
	"ahmedkhalf/project.nvim",
	-- which key
	{
		"folke/which-key.nvim",
		opts = {},
	},
	--'hrsh7th/cmp-nvim-lsp-signature-help',
	"ray-x/lsp_signature.nvim",
	{
		"kevinhwang91/nvim-fundo",
		dependencies = "kevinhwang91/promise-async",
		build = function()
			require("fundo").install()
		end,
	},
	"mbbill/undotree",

	"untitled-ai/jupyter_ascending.vim",
	"epwalsh/obsidian.nvim",
	-- some ai plugins
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	--use {'akinsho/git-conflict.nvim', tag = "*", config = function()
	--    require('git-conflict').setup()
	--end}
	--git diff
	"tpope/vim-fugitive",
	-- code folding
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
	-- formatter
	"mhartington/formatter.nvim",
	"jbyuki/nabla.nvim",
	-- fix trouble
	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- add any options here
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },
	{
		"numToStr/Comment.nvim",
		lazy = false,
	},
	{ "nvim-neotest/nvim-nio" },
	{
		"wintermute-cell/gitignore.nvim",
		config = function()
			require("gitignore")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"SmiteshP/nvim-navbuddy",
				dependencies = {
					"SmiteshP/nvim-navic",
					"MunifTanjim/nui.nvim",
				},
				opts = { lsp = { auto_attach = true } },
			},
		},
	},
})
