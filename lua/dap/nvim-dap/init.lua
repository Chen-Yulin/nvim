local dap = require("dap")
local dapui = require("dapui")
require("nvim-dap-virtual-text").setup({
	commented = true,
})

-- 定义各种图标

vim.fn.sign_define("DapBreakpoint", {
	text = "🛑",
	texthl = "LspDiagnosticsSignError",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapStopped", {
	text = "",
	texthl = "LspDiagnosticsSignInformation",
	linehl = "DiagnosticUnderlineInfo",
	numhl = "LspDiagnosticsSignInformation",
})

vim.fn.sign_define("DapBreakpointRejected", {
	text = "",
	texthl = "LspDiagnosticsSignHint",
	linehl = "",
	numhl = "",
})

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "o", "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"repl",
			},
			size = 15,
			position = "bottom",
		},
		{
			elements = {
				"console",
			},
			size = 35,
			position = "right",
		},
	},
	controls = {
		-- Requires Neovim nightly (or 0.8 when released)
		enabled = true,
		-- Display controls in this element
		element = "repl",
		icons = {
			pause = "",
			play = "",
			step_into = "11",
			step_over = "10",
			step_out = "9",
			step_back = "",
			run_last = "ﰇ",
			terminate = "4",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
	},
}) -- use default
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
	vim.api.nvim_command("DapVirtualTextEnable")
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	vim.api.nvim_command("DapVirtualTextDisable")
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	vim.api.nvim_command("DapVirtualTextDisable")
	dapui.close()
end
dap.listeners.before.disconnected["dapui_config"] = function()
	vim.api.nvim_command("DapVirtualTextDisable")
	dapui.close()
end

-- 绑定 nvim-dap 快捷键
require("keybindings").mapDAP()
