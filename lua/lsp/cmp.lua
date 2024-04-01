local cmp = require("cmp")
local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end
cmp.setup({
	completion = {
		--autocomplete = {
		--    cmp.TriggerEvent.TextChanged,
		--    cmp.TriggerEvent.InsertEnter,
		--},
		completeopt = "menu,menuone,preview,noinsert,noselect",
		keyword_length = 0,
	},
	-- 指定 snippet 引擎
	snippet = {
		expand = function(args)
			-- For `vsnip` users.
			vim.fn["vsnip#anonymous"](args.body)

			-- For `luasnip` users.
			-- require('luasnip').lsp_expand(args.body)

			-- For `ultisnips` users.
			-- vim.fn["UltiSnips#Anon"](args.body)

			-- For `snippy` users.
			-- require'snippy'.expand_snippet(args.body)
		end,
	},
	-- 补全源
	sources = cmp.config.sources({
		{ name = "path" },
		-- Copilot Source
		{ name = "copilot", group_index = 2 },
		-- For vsnip users.
		{ name = "vsnip" },
		{ name = "nvim_lsp", trigger_characters = { "." } },
		{ name = "orgmode" },
		--{ name = 'nvim_lsp_signature_help' },

		-- For luasnip users.
		--{ name = 'luasnip' },

		--For ultisnips users.
		--{ name = 'ultisnips' },

		-- -- For snippy users.
		--{ name = 'snippy' },
	}, { { name = "buffer" }, { name = "path" } }),

	-- 快捷键设置
	mapping = require("keybindings").cmp(cmp),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	-- 使用lspkind-nvim显示类型图标 (新增)
	formatting = require("lsp.ui").formatting,
})

-- / 查找模式使用 buffer 源
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- : 命令行模式中使用 path 和 cmdline 源.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
