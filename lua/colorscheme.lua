-- local colorscheme = "sonokai"
-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- vim.g.sonokai_transparent_background = 1
-- vim.g.sonokai_style = "andromeda"
-- if not status_ok then
-- 	vim.notify("colorscheme " .. colorscheme .. " 没有找到！")
-- 	return
-- end
--
-- require("catppuccin").setup({
-- 	flavour = "latte", -- latte, frappe, macchiato, mocha
-- 	background = { -- :h background
-- 		light = "latte",
-- 		dark = "mocha",
-- 	},
-- 	transparent_background = false, -- disables setting the background color.
-- 	show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
-- 	term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
-- 	dim_inactive = {
-- 		enabled = false, -- dims the background color of inactive window
-- 		shade = "dark",
-- 		percentage = 0.15, -- percentage of the shade to apply to the inactive window
-- 	},
-- 	no_italic = false, -- Force no italic
-- 	no_bold = false, -- Force no bold
-- 	no_underline = false, -- Force no underline
-- 	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
-- 		comments = { "italic" }, -- Change the style of comments
-- 		conditionals = { "italic" },
-- 		loops = {},
-- 		functions = {},
-- 		keywords = {},
-- 		strings = {},
-- 		variables = {},
-- 		numbers = {},
-- 		booleans = {},
-- 		properties = {},
-- 		types = {},
-- 		operators = {},
-- 		-- miscs = {}, -- Uncomment to turn off hard-coded styles
-- 	},
-- 	color_overrides = {},
-- 	custom_highlights = {},
-- 	default_integrations = true,
-- 	integrations = {
-- 		cmp = true,
-- 		gitsigns = true,
-- 		nvimtree = true,
-- 		treesitter = true,
-- 		notify = false,
-- 		mini = {
-- 			enabled = true,
-- 			indentscope_color = "",
-- 		},
-- 		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
-- 	},
-- })
--
-- vim.cmd.colorscheme("catppuccin")

require("github-theme").setup({
	options = {
		-- Compiled file's destination location
		compile_path = vim.fn.stdpath("cache") .. "/github-theme",
		compile_file_suffix = "_compiled", -- Compiled file suffix
		hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
		hide_nc_statusline = true, -- Override the underline style for non-active statuslines
		transparent = false, -- Disable setting bg (make neovim's background transparent)
		terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
		dim_inactive = false, -- Non focused panes set to alternative background
		module_default = true, -- Default enable value for modules
		styles = { -- Style to be applied to different syntax groups
			comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
			functions = "NONE",
			keywords = "NONE",
			variables = "NONE",
			conditionals = "NONE",
			constants = "NONE",
			numbers = "NONE",
			operators = "NONE",
			strings = "NONE",
			types = "NONE",
		},
		inverse = { -- Inverse highlight for different types
			match_paren = false,
			visual = false,
			search = false,
		},
		darken = { -- Darken floating windows and sidebar-like windows
			floats = true,
			sidebars = {
				enable = true,
				list = {}, -- Apply dark background to specific windows
			},
		},
		modules = { -- List of various plugins and additional options
			-- ...
		},
	},
	palettes = {},
	specs = {},
	groups = {},
})

vim.cmd("colorscheme github_light_tritanopia")

-- -- Default options
-- require("nightfox").setup({
-- 	options = {
-- 		-- Compiled file's destination location
-- 		compile_path = vim.fn.stdpath("cache") .. "/nightfox",
-- 		compile_file_suffix = "_compiled", -- Compiled file suffix
-- 		transparent = false, -- Disable setting background
-- 		terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
-- 		dim_inactive = false, -- Non focused panes set to alternative background
-- 		module_default = true, -- Default enable value for modules
-- 		colorblind = {
-- 			enable = false, -- Enable colorblind support
-- 			simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
-- 			severity = {
-- 				protan = 0, -- Severity [0,1] for protan (red)
-- 				deutan = 0, -- Severity [0,1] for deutan (green)
-- 				tritan = 0, -- Severity [0,1] for tritan (blue)
-- 			},
-- 		},
-- 		styles = { -- Style to be applied to different syntax groups
-- 			comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
-- 			conditionals = "NONE",
-- 			constants = "NONE",
-- 			functions = "NONE",
-- 			keywords = "NONE",
-- 			numbers = "NONE",
-- 			operators = "NONE",
-- 			strings = "NONE",
-- 			types = "NONE",
-- 			variables = "NONE",
-- 		},
-- 		inverse = { -- Inverse highlight for different types
-- 			match_paren = true,
-- 			visual = false,
-- 			search = true,
-- 		},
-- 		modules = { -- List of various plugins and additional options
-- 			-- ...
-- 		},
-- 	},
-- 	palettes = {},
-- 	specs = {},
-- 	groups = {},
-- })
--
-- -- setup must be called before loading
-- vim.cmd("colorscheme dayfox")
