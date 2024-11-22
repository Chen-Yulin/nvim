local status, db = pcall(require, "colorful_diff")
if not status then
	vim.notify("没有找到 colorful_diff")
	return
end

local config = {
	colors = {
		origin = "#445522", -- color for the original part
		diff = "#225544", -- color for the incoming change
	},
	refresh_cycle = 50,
}

db.setup(config)
