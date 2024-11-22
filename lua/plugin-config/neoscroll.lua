local status, db = pcall(require, "neoscroll")
if not status then
	vim.notify("没有找到 neoscroll")
	return
end
require("neoscroll").setup()

-- `gc` for line comment, `gb` for block comment
