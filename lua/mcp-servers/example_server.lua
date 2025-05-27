-- Example MCP Server for mcphub.nvim
local M = {}

-- Define the server
M.server = {
	name = "example_server",
	display_name = "Example Server",
	description = "An example MCP server with basic capabilities",
	version = "1.0.0",

	-- Define tools that the server provides
	tools = {
		{
			name = "get_current_file",
			description = "Get the content of the current file",
			parameters = {},
			handler = function(params, context, response)
				local current_buf = vim.api.nvim_get_current_buf()
				local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
				local content = table.concat(lines, "\n")

				return response:text(content)
			end,
		},

		{
			name = "get_file_info",
			description = "Get information about the current file",
			parameters = {},
			handler = function(params, context, response)
				local current_buf = vim.api.nvim_get_current_buf()
				local filename = vim.api.nvim_buf_get_name(current_buf)
				local filetype = vim.bo[current_buf].filetype
				local line_count = vim.api.nvim_buf_line_count(current_buf)

				local info = {
					filename = filename,
					filetype = filetype,
					line_count = line_count,
				}

				return response:text(vim.inspect(info))
			end,
		},

		{
			name = "search_in_file",
			description = "Search for a pattern in the current file",
			parameters = {
				{
					name = "pattern",
					description = "The pattern to search for",
					type = "string",
					required = true,
				},
			},
			handler = function(params, context, response)
				local pattern = params.pattern
				local current_buf = vim.api.nvim_get_current_buf()
				local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)

				local results = {}
				for i, line in ipairs(lines) do
					if line:match(pattern) then
						table.insert(results, { line_number = i, content = line })
					end
				end

				if #results == 0 then
					return response:text("No matches found for pattern: " .. pattern)
				else
					local output = "Found " .. #results .. " matches for pattern: " .. pattern .. "\n\n"
					for _, result in ipairs(results) do
						output = output .. "Line " .. result.line_number .. ": " .. result.content .. "\n"
					end
					return response:text(output)
				end
			end,
		},
	},

	-- Define resources that the server provides
	resources = {
		{
			name = "neovim_help",
			description = "Information about Neovim",
			content = [[
# Neovim Help
Neovim is a hyperextensible Vim-based text editor that seeks to aggressively refactor Vim.

## Key Features
- Modern UI
- Advanced plugin system
- Embedded terminal
- Asynchronous job control
- Lua integration
      ]],
		},
	},

	-- Define templates/prompts that the server provides
	templates = {
		{
			name = "explain_code",
			display_name = "Explain Code",
			description = "Explain the selected code",
			prompt = [[
Please explain the following code:

```{{filetype}}
{{selection}}
```

Provide a detailed explanation of:
1. What the code does
2. How it works
3. Any potential issues or improvements
      ]],
		},
		{
			name = "refactor_code",
			display_name = "Refactor Code",
			description = "Suggest refactoring for the selected code",
			prompt = [[
Please suggest refactoring for the following code:

```{{filetype}}
{{selection}}
```

Provide:
1. Refactored version of the code
2. Explanation of the changes
3. Benefits of the refactoring
      ]],
		},
	},
}

-- Register the server with mcphub
function M.setup()
	local status, mcphub = pcall(require, "mcphub")
	if not status then
		vim.notify("mcphub.nvim not found", vim.log.levels.ERROR)
		return
	end

	mcphub.add_server(M.server)
	vim.notify("Example MCP server registered successfully", vim.log.levels.INFO)
end

return M
