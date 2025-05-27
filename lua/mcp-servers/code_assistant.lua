-- Code Assistant MCP Server for mcphub.nvim
local M = {}

-- Helper function to get selected text
local function get_visual_selection()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_line, start_col = start_pos[2], start_pos[3]
	local end_line, end_col = end_pos[2], end_pos[3]

	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

	if #lines == 0 then
		return ""
	end

	if #lines == 1 then
		lines[1] = string.sub(lines[1], start_col, end_col)
	else
		lines[1] = string.sub(lines[1], start_col)
		lines[#lines] = string.sub(lines[#lines], 1, end_col)
	end

	return table.concat(lines, "\n")
end

-- Define the server
M.server = {
	name = "code_assistant",
	display_name = "Code Assistant",
	description = "A code analysis and refactoring MCP server for Neovim",
	version = "1.0.0",

	-- Define tools that the server provides
	tools = {
		{
			name = "analyze_function",
			description = "Analyze a function in the current buffer",
			parameters = {
				{
					name = "function_name",
					description = "Name of the function to analyze",
					type = "string",
					required = true,
				},
			},
			handler = function(params, context, response)
				local function_name = params.function_name
				local current_buf = vim.api.nvim_get_current_buf()
				local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
				local content = table.concat(lines, "\n")

				-- Simple pattern matching to find the function
				local pattern = "function%s+" .. function_name .. "%s*%(.-%).-end"
				local function_body = content:match(pattern)

				if not function_body then
					return response:error("Function '" .. function_name .. "' not found in the current buffer")
				end

				-- Simple analysis
				local analysis = {
					name = function_name,
					length = #function_body:split("\n"),
					has_return = function_body:match("return") ~= nil,
					has_loops = function_body:match("for") ~= nil or function_body:match("while") ~= nil,
					has_conditionals = function_body:match("if") ~= nil,
					calls_other_functions = function_body:match("%w+%(") ~= nil,
				}

				local output = "Analysis of function '" .. function_name .. "':\n\n"
				output = output .. "- Length: " .. analysis.length .. " lines\n"
				output = output .. "- Has return statement: " .. tostring(analysis.has_return) .. "\n"
				output = output .. "- Contains loops: " .. tostring(analysis.has_loops) .. "\n"
				output = output .. "- Contains conditionals: " .. tostring(analysis.has_conditionals) .. "\n"
				output = output .. "- Calls other functions: " .. tostring(analysis.calls_other_functions) .. "\n"

				return response:text(output)
			end,
		},

		{
			name = "extract_selection_to_function",
			description = "Extract selected code to a new function",
			parameters = {
				{
					name = "function_name",
					description = "Name for the new function",
					type = "string",
					required = true,
				},
			},
			handler = function(params, context, response)
				local function_name = params.function_name
				local selection = get_visual_selection()

				if selection == "" then
					return response:error("No text selected")
				end

				-- Indent the selection
				local indented_selection = ""
				for line in selection:gmatch("[^\r\n]+") do
					indented_selection = indented_selection .. "  " .. line .. "\n"
				end

				-- Create the function
				local function_code = "function " .. function_name .. "()\n" .. indented_selection .. "end\n"

				-- Insert the function at the end of the file
				local current_buf = vim.api.nvim_get_current_buf()
				local line_count = vim.api.nvim_buf_line_count(current_buf)
				vim.api.nvim_buf_set_lines(current_buf, line_count, line_count, false, vim.split(function_code, "\n"))

				return response:text("Extracted selection to function '" .. function_name .. "' at the end of the file")
			end,
		},

		{
			name = "count_lines_of_code",
			description = "Count lines of code in the current buffer",
			parameters = {
				{
					name = "exclude_comments",
					description = "Whether to exclude comment lines",
					type = "boolean",
					required = false,
					default = false,
				},
				{
					name = "exclude_blank_lines",
					description = "Whether to exclude blank lines",
					type = "boolean",
					required = false,
					default = false,
				},
			},
			handler = function(params, context, response)
				local exclude_comments = params.exclude_comments or false
				local exclude_blank_lines = params.exclude_blank_lines or false

				local current_buf = vim.api.nvim_get_current_buf()
				local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)

				local total_lines = #lines
				local code_lines = total_lines
				local comment_lines = 0
				local blank_lines = 0

				-- Get filetype to determine comment syntax
				local filetype = vim.bo[current_buf].filetype
				local comment_pattern

				if filetype == "lua" then
					comment_pattern = "^%s*%-%-"
				elseif filetype == "python" then
					comment_pattern = "^%s*#"
				elseif
					filetype == "javascript"
					or filetype == "typescript"
					or filetype == "c"
					or filetype == "cpp"
					or filetype == "java"
				then
					comment_pattern = "^%s*(//)|(/%*)"
				else
					-- Default pattern that might work for many languages
					comment_pattern = "^%s*[#-/]"
				end

				-- Count lines
				for _, line in ipairs(lines) do
					if line:match("^%s*$") then
						blank_lines = blank_lines + 1
						if exclude_blank_lines then
							code_lines = code_lines - 1
						end
					elseif comment_pattern and line:match(comment_pattern) then
						comment_lines = comment_lines + 1
						if exclude_comments then
							code_lines = code_lines - 1
						end
					end
				end

				local output = "Lines of code statistics:\n\n"
				output = output .. "- Total lines: " .. total_lines .. "\n"
				output = output .. "- Code lines: " .. code_lines .. "\n"
				output = output .. "- Comment lines: " .. comment_lines .. "\n"
				output = output .. "- Blank lines: " .. blank_lines .. "\n"

				return response:text(output)
			end,
		},
	},

	-- Define resources that the server provides
	resources = {
		{
			name = "code_style_guide",
			description = "Code style guidelines",
			content = [[
# Code Style Guide

## General Principles
- Write clean, readable code
- Use consistent naming conventions
- Keep functions small and focused
- Comment complex logic
- Avoid deep nesting

## Naming Conventions
- Use camelCase for variables and functions
- Use PascalCase for classes and types
- Use UPPER_CASE for constants
- Use descriptive names that convey purpose

## Formatting
- Use consistent indentation (2 or 4 spaces)
- Limit line length to 80-100 characters
- Use blank lines to separate logical sections
- Place opening braces on the same line
- Use spaces around operators

## Comments
- Write comments that explain why, not what
- Keep comments up-to-date with code changes
- Use documentation comments for public APIs
- Avoid redundant comments
      ]],
		},
	},

	-- Define templates/prompts that the server provides
	templates = {
		{
			name = "optimize_code",
			display_name = "Optimize Code",
			description = "Suggest optimizations for the selected code",
			prompt = [[
Please suggest optimizations for the following code:

```{{filetype}}
{{selection}}
```

Focus on:
1. Performance improvements
2. Memory usage optimization
3. Algorithmic efficiency
4. Code readability
5. Best practices for {{filetype}}

Provide:
1. Optimized version of the code
2. Explanation of each optimization
3. Expected benefits (e.g., faster execution, reduced memory usage)
      ]],
		},
		{
			name = "add_documentation",
			display_name = "Add Documentation",
			description = "Generate documentation for the selected code",
			prompt = [[
Please generate comprehensive documentation for the following code:

```{{filetype}}
{{selection}}
```

Include:
1. Function/class purpose
2. Parameter descriptions
3. Return value descriptions
4. Usage examples
5. Edge cases and error handling
6. Any dependencies or prerequisites

Format the documentation according to the conventions of {{filetype}}.
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

	-- Add string.split function if it doesn't exist
	if not string.split then
		string.split = function(str, sep)
			if sep == nil then
				sep = "%s"
			end
			local t = {}
			for s in string.gmatch(str, "([^" .. sep .. "]+)") do
				table.insert(t, s)
			end
			return t
		end
	end

	mcphub.add_server(M.server)
	vim.notify("Code Assistant MCP server registered successfully", vim.log.levels.INFO)
end

return M
