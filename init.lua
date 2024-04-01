require("lazy_setup")
-- for neovide
if vim.g.neovide then
	vim.o.guifont = "FuraMono Nerd Font Mono:h14"
	vim.g.neovide_scale_factor = 0.6
	vim.g.neovide_transparency = 0.9
	vim.g.neovide_scroll_animation_length = 0.2
	vim.g.neovide_floating_blur_amount_x = 2
	vim.g.neovide_floating_blur_amount_y = 2
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_cursor_trail_length = 0.05
	vim.g.neovide_cursor_animation_length = 0.05
else
	require("plugin-config.transparent")
end

require("vimscript")
require("basic")
require("keybindings")
require("colorscheme")
require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.lualine")
require("plugin-config.telescope")
require("plugin-config.nvim-treesitter")
require("lsp.setup")
require("lsp.cmp")
require("plugin-config.indent-blankline")
require("dap.nvim-dap.init")
require("dap.nvim-dap.dap-cpp")
require("leap").add_default_mappings()
require("plugin-config.dashboard")
require("plugin-config.project")
require("plugin-config.autopairs")

vim.o.undofile = true
require("fundo").setup()
require("plugin-config.obsidian")
-- require('plugin-config.git-conflict')
require("plugin-config.nvim-ufo")
require("plugin-config.formatter")
require("plugin-config.copilot")
require("plugin-config.lspkind")
require("plugin-config.notify")
require("plugin-config.noice")
require("plugin-config.comment")
