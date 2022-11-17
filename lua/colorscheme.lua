local colorscheme = "sonokai"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
vim.g.sonokai_transparent_background = 1
vim.g.sonokai_style = 'andromeda'
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " 没有找到！")
    return
end
