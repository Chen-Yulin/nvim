local status_ok, diffview = pcall(require, "diffview")
if not status_ok then
	return
end

diffview.setup({
	diff_binaries = false, -- Show diffs for binaries
	enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
	git_cmd = { "git" }, -- The git executable followed by default args.
	use_icons = true, -- Requires nvim-web-devicons
	icons = { -- Only applies when use_icons is true.
		folder_closed = "",
		folder_open = "",
	},
	signs = {
		fold_closed = "",
		fold_open = "",
	},
	file_panel = {
		listing_style = "tree", -- One of 'list' or 'tree'
		tree_options = { -- Only applies when listing_style is 'tree'
			flatten_dirs = true, -- Flatten dirs that only contain one single dir
			folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
		},
		win_config = { -- See ':h diffview-config-win_config'
			position = "left",
			width = 35,
		},
	},
	file_history_panel = {
		log_options = {
			git = {
				single_file = {
					max_count = 512,
					follow = true,
				},
				multi_file = {
					max_count = 128,
				},
			},
		},
	},

	commit_log_panel = {
		win_config = {}, -- See ':h diffview-config-win_config'
	},
	default_args = { -- Default args prepended to the arg-list for the listed commands
		DiffviewOpen = {},
		DiffviewFileHistory = {},
	},
	hooks = {}, -- See ':h diffview-config-hooks'
	keymaps = {
		disable_defaults = false, -- Disable the default keymaps
		view = {
			-- The `view` bindings are active in the diff buffers, only when the current
			-- tabpage is a Diffview.
			["<tab>"] = function()
				vim.cmd("DiffviewToggleFiles")
			end,
			["gf"] = function()
				vim.cmd("DiffviewToggleFiles")
			end,
			["<leader>e"] = function()
				vim.cmd("DiffviewFocusFiles")
			end,
			["<leader>b"] = function()
				vim.cmd("DiffviewToggleFiles")
			end,
		},
		file_panel = {
			["j"] = function()
				vim.cmd("normal! j")
			end,
			["<down>"] = function()
				vim.cmd("normal! j")
			end,
			["k"] = function()
				vim.cmd("normal! k")
			end,
			["<up>"] = function()
				vim.cmd("normal! k")
			end,
			["<cr>"] = function()
				vim.cmd("DiffviewOpen")
			end,
			["o"] = function()
				vim.cmd("DiffviewOpen")
			end,
			["<2-LeftMouse>"] = function()
				vim.cmd("DiffviewOpen")
			end,
			["s"] = function()
				vim.cmd("DiffviewOpen split")
			end,
			["S"] = function()
				vim.cmd("DiffviewOpen vsplit")
			end,
			["<C-u>"] = function()
				vim.cmd("normal! <C-u>")
			end,
			["<C-d>"] = function()
				vim.cmd("normal! <C-d>")
			end,
			["gf"] = function()
				vim.cmd("DiffviewToggleFiles")
			end,
			["<C-n>"] = function()
				vim.cmd("DiffviewRefresh")
			end,
			["<leader>e"] = function()
				vim.cmd("DiffviewFocusFiles")
			end,
		},
		file_history_panel = {
			["g!"] = function()
				vim.cmd("DiffviewToggleFiles")
			end,
			["<C-A-d>"] = function()
				vim.cmd("DiffviewToggleFiles")
			end,
			["<leader>e"] = function()
				vim.cmd("DiffviewFocusFiles")
			end,
		},
	},
})
