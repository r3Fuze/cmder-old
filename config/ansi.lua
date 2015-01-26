ansi = {}

ansi.colors = {
    -- attributes
    reset = 0,
    clear = 0,
    bright = 1,
    dim = 2,
    underscore = 4,
    blink = 5,
    reverse = 7,
    hidden = 8,

    -- foreground
    black = 30,
    red = 31,
    green = 32,
    yellow = 33,
    blue = 34,
    magenta = 35,
    cyan = 36,
    white = 37,

    -- background
    bgblack = 40,
    bgred = 41,
    bggreen = 42,
    bgyellow = 43,
    bgblue = 44,
    bgmagenta = 45,
    bgcyan = 46,
    bgwhite = 47,
}

-- Magic.. Credit: https://github.com/kmarkus/rFSM/blob/master/utils.lua#L125
function ansi.strip(str)
    return string.gsub(str, "\27%[%d+m", "")
end

for k, v in pairs(ansi.colors) do
    ansi[k] = string.char(27) .. "[" .. tostring(v) .. "m"
end

return ansi