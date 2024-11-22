local status, db = pcall(require, "Comment")
if not status then
	vim.notify("没有找到 Comment")
	return
end
require("Comment").setup()

-- `gc` for line comment, `gb` for block comment
