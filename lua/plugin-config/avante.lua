local status, avante = pcall(require, "avante")
if not status then
	vim.notify("没有找到 avante")
	return
end

avante.setup({
	---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
	provider = "claude", -- Recommend using Claude
	-- auto_suggestions_provider = "claude", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
	claude = {
		endpoint = "https://api.anthropic.com",
		model = "claude-3-5-sonnet-20240620",
		temperature = 0,
		max_tokens = 4096,
	},
	behaviour = {
		auto_suggestions = false, -- Experimental stage
		auto_set_highlight_group = true,
		auto_set_keymaps = true,
		auto_apply_diff_after_generation = false,
		support_paste_from_clipboard = true,
		minimize_diff = true,
		enable_claude_text_editor_tool_mode = true,
		enable_cursor_planning_mode = true,
	},
	-- disabled_tools = {
	-- 	"list_files", -- Built-in file operations
	-- 	"search_files",
	-- 	"read_file",
	-- 	"create_file",
	-- 	"rename_file",
	-- 	"delete_file",
	-- 	"create_dir",
	-- 	"rename_dir",
	-- 	"delete_dir",
	-- 	"bash", -- Built-in terminal access
	-- },
	vendors = {
		groq = { -- define groq provider
			__inherited_from = "openai",
			api_key_name = "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",
			endpoint = "https://api.groq.com/openai/v1/",
			model = "llama-3.3-70b-versatile",
			max_completion_tokens = 65536, -- remember to increase this value, otherwise it will stop generating halfway
		},
	},
	mappings = {
		--- @class AvanteConflictMappings
		diff = {
			ours = "<leader>co",
			theirs = "<leader>ct",
			all_theirs = "<leader>ca",
			both = "<leader>cb",
			cursor = "<leader>cc",
			next = "]x",
			prev = "[x",
		},
		suggestion = {
			accept = "<M-l>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
		jump = {
			next = "]]",
			prev = "[[",
		},
		submit = {
			normal = "<CR>",
			insert = "<C-s>",
		},
		sidebar = {
			apply_all = "A",
			apply_cursor = "a",
			switch_windows = "<Tab>",
			reverse_switch_windows = "<S-Tab>",
		},
	},
	hints = { enabled = true },
	windows = {
		---@type "right" | "left" | "top" | "bottom"
		position = "right", -- the position of the sidebar
		wrap = true, -- similar to vim.o.wrap
		width = 30, -- default % based on available width
		sidebar_header = {
			align = "center", -- left, center, right for title
			rounded = true,
		},
		input = {
			prefix = "󱐒 ",
		},
		edit = {
			border = "rounded",
			start_insert = true, -- Start insert mode when opening the edit window
		},
		ask = {
			floating = true, -- Open the 'AvanteAsk' prompt in a floating window
			start_insert = true, -- Start insert mode when opening the ask window, only effective if floating = true.
			border = "rounded",
		},
	},
	highlights = {
		---@type AvanteConflictHighlights
		diff = {
			current = "DiffText",
			incoming = "DiffAdd",
		},
	},
	--- @class AvanteConflictUserConfig
	diff = {
		autojump = true,
		---@type string | fun(): any
		list_opener = "copen",
	},
	-- for mcp-hub
	-- system_prompt as function ensures LLM always has latest MCP server state
	-- This is evaluated for every message, even in existing chats
	-- system_prompt = function()
	-- 	local hub = require("mcphub").get_hub_instance()
	-- 	return hub and hub:get_active_servers_prompt() or ""
	-- end,
	-- Using function prevents requiring mcphub before it's loaded
	-- custom_tools = function()
	-- 	return {
	-- 		require("mcphub.extensions.avante").mcp_tool(),
	-- 	}
	-- end,
})
