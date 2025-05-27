local status, db = pcall(require, "copilot")
if not status then
	vim.notify("没有找到 copilot")
	return
end
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
