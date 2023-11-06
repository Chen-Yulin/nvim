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

require("basic")
require("keybindings")
require("plugins")
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
require("cmake-tools").setup({
	cmake_command = "cmake",
	cmake_build_directory = "build",
	cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
	cmake_build_options = {},
	cmake_console_size = 10, -- cmake output window height
	cmake_show_console = "always", -- "always", "only_on_error"
	cmake_dap_configuration = { name = "Launch file for c/cpp/rust", type = "cppdbg", request = "launch" }, -- dap configuration, optional
	cmake_dap_open_command = require("dap").repl.open, -- optional
	cmake_variants_message = {
		short = { show = true },
		long = { show = true, max_length = 40 },
	},
})
require("vimscript")
require("leap").add_default_mappings()
require("plugin-config.dashboard")
require("plugin-config.project")
require("plugin-config.autopairs")

vim.o.undofile = true
require("fundo").setup()
require("plugin-config.org")
require("plugin-config.obsidian")
-- require('plugin-config.git-conflict')
require("plugin-config.nvim-ufo")
require("plugin-config.formatter")
