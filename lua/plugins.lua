local packer = require("packer")
packer.startup({
    function(use)
        -- Packer 可以管理自己本身
        use('wbthomason/packer.nvim')
        -- tokyonight
        use("folke/tokyonight.nvim")
        use("sainnhe/sonokai")
        -- OceanicNext
        -- use("mhartington/oceanic-next")
        -- gruvbox
        -- use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
        -- zephyr 暂时不推荐，详见上边解释
        -- use("glepnir/zephyr-nvim")
        -- nord
        -- use("shaunsingh/nord.nvim")
        -- onedark
        -- use("ful1e5/onedark.nvim")
        -- nightfox
        -- use("EdenEast/nightfox.nvim")
        -- nvim-tree
        use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
        -- bufferline
        use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })

        -- lualine
        use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
        use("arkav/lualine-lsp-progress")
        --telescope
        use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }

        -- treesitter
        use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
        --------------------- LSP --------------------
        use("williamboman/nvim-lsp-installer")
        -- Lspconfig
        use({ "neovim/nvim-lspconfig" })
        -- 补全引擎
        use("hrsh7th/nvim-cmp")
        -- snippet 引擎
        use("hrsh7th/vim-vsnip")
        -- 补全源
        use("hrsh7th/cmp-vsnip")
        use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
        use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
        use("hrsh7th/cmp-path") -- { name = 'path' }
        use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }

        -- 常见编程语言代码段
        use("rafamadriz/friendly-snippets")
        use("SirVer/ultisnips")

        -- ui
        use("onsails/lspkind-nvim")
        -- indent-blankline
        use("lukas-reineke/indent-blankline.nvim")
        use("tami5/lspsaga.nvim")

        -- dap
        use("mfussenegger/nvim-dap")
        use("theHamsta/nvim-dap-virtual-text")
        use("rcarriga/nvim-dap-ui")
        use("ravenxrz/DAPInstall.nvim")

        use('voldikss/vim-floaterm')
        use {
            "windwp/nvim-autopairs",
            config = function() require("nvim-autopairs").setup {} end
        }
        use {
            'lervag/vimtex',
            opt = true,
            config = function()
                vim.g.vimtex_view_general_viewer = 'okular'
                vim.g.vimtex_compiler_latexmk_engines = {
                    _ = '-xelatex'
                }
                vim.g.tex_comment_nospell = 1
                vim.g.vimtex_compiler_progname = 'nvr'
                vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
                --vim.g.vimtex_view_general_options_latexmk = '--unique'
            end,
            ft = 'tex'
        }

        use('Civitasv/cmake-tools.nvim')

        use('liuchengxu/vista.vim')



    end,

    config = {
        -- 并发数限制
        max_jobs = 16,
        -- 自定义源
        git = {
            clone_timout = 512,
            default_url_format = "git@github.com:%s"
            --default_url_format = "https://hub.fastgit.xyz/%s",
            --default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
            --default_url_format = "https://gitcode.net/mirrors/%s",
            --default_url_format = "https://gitclone.com/github.com/%s",
        },
    },
})

pcall(
    vim.cmd,
    [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
