-- lspkind.lua
local status, db = pcall(require, "lspkind")
if not status then
	vim.notify("没有找到 lspkind")
	return
end
local lspkind = require("lspkind")
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
