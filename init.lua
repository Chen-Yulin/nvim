require("lazy_setup")
-- for neovide
if vim.g.neovide then
	vim.o.guifont = "Jetbrains Mono:h16"
	vim.g.neovide_scale_factor = 1
	vim.g.neovide_transparency = 0.9
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_floating_blur_amount_x = 2
	vim.g.neovide_floating_blur_amount_y = 2
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_cursor_trail_length = 0.02
	vim.g.neovide_cursor_animation_length = 0.02
else
	require("plugin-config.transparent")
end

require("vimscript")
require("basic")
require("keybindings")
require("colorscheme")
-- require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.lualine")
require("plugin-config.telescope")
require("plugin-config.nvim-treesitter")
require("lsp.setup")
require("lsp.cmp")
require("plugin-config.indent-blankline")
require("dap.nvim-dap.init")
require("dap.nvim-dap.dap-cpp")
require("dap.nvim-dap.dap-godot")
require("leap").add_default_mappings()
require("plugin-config.dashboard")
-- require("plugin-config.project")
require("plugin-config.autopairs")

vim.o.undofile = true
require("fundo").setup()
--require("plugin-config.obsidian")
-- require('plugin-config.git-conflict')
require("plugin-config.nvim-ufo")
require("plugin-config.formatter")
require("plugin-config.lspkind")
--require("plugin-config.notify")
--require("plugin-config.noice")
require("plugin-config.comment")
require("plugin-config.diffview")
require("plugin-config.avante")
-- require("plugin-config.gitconflict")
--require("avante_lib").load()
require("plugin-config.colorful-diff")
require("plugin-config.neocodeium_cfg")
require("plugin-config.neotree_cfg")
-- require("plugin-config.mcp-hub")
require("my_cmd")
vim.cmd([[
set wrap
]])
require("globals")

-- for godot
local gdproject = io.open(vim.fn.getcwd() .. "/project.godot", "r")
if gdproject then
	io.close(gdproject)
	vim.fn.serverstart("./godothost")
	vim.notify("Open godot project")
end
