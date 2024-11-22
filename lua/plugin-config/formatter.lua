local status, formatter = pcall(require, "formatter")
if not status then
	vim.notify("没有找到 formatter")
	return
end

local util = require("formatter.util")

formatter.setup({
	filetype = {
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						-- "--config-path "
						--   .. os.getenv("XDG_CONFIG_HOME")
						--   .. "/stylua/stylua.toml",
						"-",
					},
					stdin = true,
				}
			end,
		},
		c = {
			function()
				return {
					exe = "clang-format",
					args = {
						--"-style='{IndentWidth: 4}'",
						--.. os.getenv("XDG_CONFIG_HOME")
						--.. "/.config/nvim/formatter_conf/.clangd-formata",
					},
					stdin = true,
					try_node_modules = true,
				}
			end,
		},
		cpp = {
			function()
				return {
					exe = "clang-format",
					args = {
						--"-style='{IndentWidth: 4}'",
						--.. os.getenv("XDG_CONFIG_HOME")
						--.. "/.config/nvim/formatter_conf/.clang-format",
					},
					stdin = true,
					try_node_modules = true,
				}
			end,
		},
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

-- format on save
vim.api.nvim_exec(
	[[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
    augroup END
]],
	true
)
