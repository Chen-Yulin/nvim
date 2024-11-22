local status, db = pcall(require, "notify")
if not status then
	vim.notify("没有找到 notify")
	return
end

require("notify").setup({
	background_colour = "#000000",
	fps = 60,
	icons = {
		DEBUG = "",
		ERROR = "",
		INFO = "",
		TRACE = "✎",
		WARN = "",
	},
	level = 2,
	minimum_width = 50,
	render = "default",
	stages = "fade_in_slide_out",
	time_formats = {
		notification = "%T",
		notification_history = "%FT%T",
	},
	timeout = 3000,
	top_down = false,
})
