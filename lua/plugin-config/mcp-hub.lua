local status, mcphub = pcall(require, "mcphub")
if not status then
	vim.notify("没有找到 mcphub")
	return
end

-- Setup mcphub
mcphub.setup({
	auto_approve = true,
})

-- Load all MCP servers
-- require("mcp-servers.example_server").setup()
-- require("mcp-servers.git_server").setup()
-- require("mcp-servers.code_assistant").setup()

-- You can also register servers directly in this file
-- Example of a simple server defined inline:
local simple_server = {
  name = "quick_actions",
  display_name = "Quick Actions",
  description = "Simple utility actions for Neovim",
  version = "1.0.0",
  
  tools = {
    {
      name = "insert_timestamp",
      description = "Insert current timestamp at cursor position",
      parameters = {
        {
          name = "format",
          description = "Timestamp format",
          type = "string",
          required = false,
          default = "%Y-%m-%d %H:%M:%S"
        }
      },
      handler = function(params, context, response)
        local format = params.format or "%Y-%m-%d %H:%M:%S"
        local timestamp = os.date(format)
        
        -- Get current cursor position
        local win = vim.api.nvim_get_current_win()
        local cursor = vim.api.nvim_win_get_cursor(win)
        local row, col = cursor[1] - 1, cursor[2]
        
        -- Insert timestamp at cursor position
        local current_line = vim.api.nvim_get_current_line()
        local new_line = current_line:sub(1, col) .. timestamp .. current_line:sub(col + 1)
        vim.api.nvim_set_current_line(new_line)
        
        -- Move cursor after the inserted timestamp
        vim.api.nvim_win_set_cursor(win, {row + 1, col + #timestamp})
        
        return response:text("Inserted timestamp: " .. timestamp)
      end
    }
  },
  
  templates = {
    {
      name = "comment_block",
      display_name = "Generate Comment Block",
      description = "Generate a formatted comment block",
      prompt = [[
Please generate a well-formatted comment block for the following code:

```{{filetype}}
{{selection}}
```

The comment should include:
1. A brief description of what the code does
2. Parameters/arguments (if applicable)
3. Return values (if applicable)
4. Any important notes or warnings

Format the comment according to the conventions of the {{filetype}} language.
      ]]
    }
  }
}

-- Register the inline server
pcall(function() mcphub.register_server(simple_server) end)

-- Log a message to confirm all servers are loaded
vim.notify("All MCP servers loaded successfully", vim.log.levels.INFO)
