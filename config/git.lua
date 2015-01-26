-- Edit package.path to make 'require' load from 'config' folder
package.path = package.path .. string.format(";%s\\config\\?.lua", clink.get_env("CMDER_ROOT"))

ansi = require("ansi")
git = {}

---
 -- Find out current branch
 -- @return {false|git branch name}
---
function git.get_branch()
    for line in io.popen("git branch 2>nul"):lines() do
        local m = line:match("%* (.+)$")
        if m then
            return m
        end
    end

    return false
end

---
 -- Get the status of working dir
 -- @return {bool}
---
function git.get_status()
    return os.execute("git diff --quiet --ignore-submodules HEAD")
end

function git.prompt_filter()

    -- Colors for git status
    local colors = {
        clean = ansi.white,
        dirty = ansi.red .. ansi.bright
    }

    local branch = git.get_branch()
    if branch then
        -- Has branch => therefore it is a git folder, now figure out status
        if git.get_status() then
            color = colors.clean
        else
            color = colors.dirty
        end

        return color .. "(" .. branch .. ")"
    end

    -- No git present or not in git file
    return ""
end

return git