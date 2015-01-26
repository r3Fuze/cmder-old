-- Edit package.path to make 'require' load from 'config' folder
package.path = package.path .. string.format(";%s\\config\\?.lua", clink.get_env("CMDER_ROOT"))

-- TODO: Write library for common lua functions?

ansi = require("ansi")
git = require("git")

-- Customizable options for the prompt
local ICON = "λ" -- ~ λ _ $ #
local ICON_COLOR = ansi.red .. ansi.bright
local DIR_COLOR = ansi.green .. ansi.bright
local ALT_SLASH = false
local SQUIGGLY_HOME = true

function prompt_filter()
	-- Get current directory from default prompt
	prompt = clink.prompt.value

	-- Remove '>' from prompt
	prompt = string.sub(prompt, 1, string.len(prompt) - 1)

	-- Replace '\' with '/' if configured
	if ALT_SLASH then prompt = string.gsub(prompt, "\\", "/") end

	-- Replace C:\Users\Username directory with ~\Username similar to unix.
	if SQUIGGLY_HOME then prompt = string.gsub(prompt, clink.get_env("HOMEDRIVE") .. "\\Users", "~") end

	-- We set the prompt here instead of in 'init.bat'
	prompt =
		-- First part is just the promptectory
		DIR_COLOR .. prompt .. ansi.reset ..

		-- Place git status
		" " .. git.prompt_filter() .. ansi.reset ..

		-- Command input goes on a new line with cool icons!
		"\n" .. ICON_COLOR .. " " .. ICON .. " " .. ansi.reset

	-- Finally set the prompt to our string
	clink.prompt.value = prompt
end

clink.prompt.register_filter(prompt_filter, 40)