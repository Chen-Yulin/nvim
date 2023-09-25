-- map leader

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

-- 个人习惯
map("n", "ww", ":w<CR>", opt)

-- window management
-- 取消 s 默认功能
map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "s,", ":vertical resize -20<CR>", opt)
map("n", "s.", ":vertical resize +20<CR>", opt)
-- 上下比例
map("n", "sj", ":resize +10<CR>", opt)
map("n", "sk", ":resize -10<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)

-- Terminal相关
map("n", "<leader>t", ":FloatermToggle<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>:FloatermToggle<CR>", opt)

map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
--map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 上下滚动浏览
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

-- 插件快捷键

-- Telescope
-- 查找文件
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)

-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- 关闭
--"moll/vim-bbye"
map("n", "<C-w>", ":Bdelete!<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true })

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "zr", ":foldopen<CR>")
vim.keymap.set("n", "zm", ":foldclose<CR>")

local pluginKeys = {}

-- nvim-tree
-- alt + m 键打开关闭tree
map("n", "<F2>", ":NvimTreeToggle<CR>", opt)
-- 列表快捷键
pluginKeys.nvimTreeList = {
	-- 打开文件或文件夹
	{ key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
	-- 分屏打开文件
	{ key = "v", action = "vsplit" },
	{ key = "h", action = "split" },
	-- 显示隐藏文件
	{ key = "i", action = "toggle_custom" }, -- 对应 filters 中的 custom (node_modules)
	{ key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
	-- 文件操作
	{ key = "R", action = "refresh" },
	{ key = "a", action = "create" },
	{ key = "d", action = "remove" },
	{ key = "r", action = "rename" },
	{ key = "x", action = "cut" },
	{ key = "c", action = "copy" },
	{ key = "p", action = "paste" },
	{ key = "s", action = "system_open" },
}

pluginKeys.telescopeList = {
	i = {
		-- 上下移动
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
		["<Down>"] = "move_selection_next",
		["<Up>"] = "move_selection_previous",
		-- 历史记录
		["<C-n>"] = "cycle_history_next",
		["<C-p>"] = "cycle_history_prev",
		-- 关闭窗口
		["<C-c>"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",
	},
}

-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
	-- rename
	--[[
  Lspsaga 替换 rn
  mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
  --]]
	mapbuf("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opt)
	-- code action
	--[[
  Lspsaga 替换 ca
  mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
  --]]
	mapbuf("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)
	-- go xxx
	-- mapbuf('n', 'gd', '<cmd>Lspsaga preview_definition<CR>', opt)
	mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
	--[[
  Lspsaga 替换 gh
  mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  --]]
	mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opt)
	--[[
  Lspsaga 替换 gr
  mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  --]]
	mapbuf("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)
	--[[
  Lspsaga 替换 gp, gj, gk
  mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
  mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
  mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
  --]]
	-- diagnostic
	mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
	mapbuf("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
	mapbuf("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
	mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
	-- 未用
	-- mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
	-- mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
	-- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
	-- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
	-- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
	-- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
	-- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
	-- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

-- lsp key binding
--map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opt)
--map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)
--map('n', 'gd', '<cmd>Lspsaga preview_definition<CR>', opt)
--map("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opt)
--map("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)
--map("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
--map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
--map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
--map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
	local feedkey = function(key, mode)
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
	end

	return {
		-- 出现补全
		["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- 取消
		--["<Esc>"] = cmp.mapping({
		--    i = cmp.mapping.abort(),
		--    c = cmp.mapping.close()
		--}),
		-- 上一个
		["<C-Up>"] = cmp.mapping.select_prev_item({}),
		-- 下一个
		["<C-Down>"] = cmp.mapping.select_next_item({}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		-- 确认
		["<CR>"] = cmp.mapping.confirm({

			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		-- 如果窗口内容太多，可以滚动
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

		-- 自定义代码段跳转到下一个参数
		["<C-j>"] = cmp.mapping(function(_)
			if vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			end
		end, { "i", "s" }),

		-- 自定义代码段跳转到上一个参数
		["<C-k>"] = cmp.mapping(function()
			if vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	}
end

-- nvim-dap
pluginKeys.mapDAP = function()
	-- 开始
	map("n", "<leader>dd", ":RustDebuggables<CR>", opt)
	-- 结束 (dapui无法自动关闭可能是bug，手动关闭能想到的一切)
	map(
		"n",
		"<F4>",
		":lua require'dap'.close()<CR>"
			.. ":lua require'dap'.terminate()<CR>"
			.. ":lua require'dap.repl'.close()<CR>"
			.. ":lua require'dapui'.close()<CR>"
			.. ":lua require('dap').clear_breakpoints()<CR>"
			.. "<C-w>o<CR>",
		opt
	)
	-- 继续
	map("n", "<F5>", ":lua require'dap'.continue()<CR>", opt)
	-- 设置断点
	map("n", "<F8>", ":lua require('dap').toggle_breakpoint()<CR>", opt)
	map("n", "<F7>", ":lua require('dap').clear_breakpoints()<CR>", opt)
	--  stepOver, stepOut, stepInto
	map("n", "<F10>", ":lua require'dap'.step_over()<CR>", opt)
	map("n", "<F9>", ":lua require'dap'.step_out()<CR>", opt)
	map("n", "<F11>", ":lua require'dap'.step_into()<CR>", opt)
	-- 弹窗
	map("n", "<leader>dh", ":lua require'dapui'.eval()<CR>", opt)
end

return pluginKeys
