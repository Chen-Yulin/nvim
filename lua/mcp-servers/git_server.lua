-- Git MCP Server for mcphub.nvim
local M = {}

-- Helper function to run git commands
local function run_git_command(command)
	local handle = io.popen("git " .. command .. " 2>&1")
	if not handle then
		return nil, "Failed to execute git command"
	end

	local result = handle:read("*a")
	handle:close()
	return result
end

-- Define the server
M.server = {
	name = "git_server",
	display_name = "Git Server",
	description = "A Git integration MCP server for Neovim",
	version = "1.0.0",

	-- Define tools that the server provides
	tools = {
		{
			name = "git_status",
			description = "Get the git status of the current repository",
			parameters = {},
			handler = function(params, context, response)
				local status, err = run_git_command("status")
				if not status then
					return response:error(err)
				end

				return response:text(status)
			end,
		},

		{
			name = "git_log",
			description = "Get the git log of the current repository",
			parameters = {
				{
					name = "limit",
					description = "Limit the number of commits to show",
					type = "number",
					required = false,
					default = 10,
				},
				{
					name = "format",
					description = "Format of the log output",
					type = "string",
					required = false,
					default = "oneline",
				},
			},
			handler = function(params, context, response)
				local limit = params.limit or 10
				local format = params.format or "oneline"

				local format_arg = ""
				if format == "oneline" then
					format_arg = "--oneline"
				elseif format == "full" then
					format_arg = "--pretty=full"
				elseif format == "short" then
					format_arg = "--pretty=short"
				end

				local log, err = run_git_command("log " .. format_arg .. " -n " .. limit)
				if not log then
					return response:error(err)
				end

				return response:text(log)
			end,
		},

		{
			name = "git_diff",
			description = "Get the git diff of the current repository",
			parameters = {
				{
					name = "file",
					description = "The file to get the diff for",
					type = "string",
					required = false,
				},
				{
					name = "staged",
					description = "Whether to show staged changes",
					type = "boolean",
					required = false,
					default = false,
				},
			},
			handler = function(params, context, response)
				local file = params.file or ""
				local staged = params.staged or false

				local cmd = "diff "
				if staged then
					cmd = cmd .. "--staged "
				end
				cmd = cmd .. file

				local diff, err = run_git_command(cmd)
				if not diff then
					return response:error(err)
				end

				if diff == "" then
					return response:text("No changes found.")
				end

				return response:text(diff)
			end,
		},

		{
			name = "git_blame",
			description = "Get git blame information for a file",
			parameters = {
				{
					name = "file",
					description = "The file to get blame information for",
					type = "string",
					required = true,
				},
			},
			handler = function(params, context, response)
				local file = params.file

				local blame, err = run_git_command("blame " .. file)
				if not blame then
					return response:error(err)
				end

				return response:text(blame)
			end,
		},
	},

	-- Define resources that the server provides
	resources = {
		{
			name = "git_cheatsheet",
			description = "Git command cheatsheet",
			content = [[
# Git Cheatsheet

## Basic Commands
- `git init` - Initialize a new git repository
- `git clone <url>` - Clone a repository
- `git add <file>` - Add file to staging area
- `git commit -m "message"` - Commit changes
- `git push` - Push changes to remote
- `git pull` - Pull changes from remote

## Branching
- `git branch` - List branches
- `git branch <name>` - Create a new branch
- `git checkout <branch>` - Switch to branch
- `git merge <branch>` - Merge branch into current branch

## Information
- `git status` - Show repository status
- `git log` - Show commit history
- `git diff` - Show changes
- `git blame <file>` - Show who changed what in a file
      ]],
		},
	},

	-- Define templates/prompts that the server provides
	templates = {
		{
			name = "generate_commit_message",
			display_name = "Generate Commit Message",
			description = "Generate a commit message based on the changes",
			prompt = [[
Please generate a concise and descriptive commit message for the following changes:

```diff
{{git_diff}}
```

Follow these guidelines:
1. Use the imperative mood (e.g., "Add feature" not "Added feature")
2. Keep the first line under 50 characters
3. Provide more details in subsequent lines if necessary
4. Reference any relevant issue numbers
      ]],
		},
		{
			name = "explain_git_error",
			display_name = "Explain Git Error",
			description = "Explain a git error message",
			prompt = [[
Please explain the following git error message and suggest how to resolve it:

```
{{selection}}
```

Provide:
1. A clear explanation of what the error means
2. The likely cause of the error
3. Step-by-step instructions to resolve the issue
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
	vim.notify("Git MCP server registered successfully", vim.log.levels.INFO)
end

return M
