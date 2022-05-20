local home = os.getenv("HOME")

local term = "alacritty"
local editor = os.getenv("EDITOR") or "vim"

local _M = {
  terminal = term,
  editor = editor,
  editor_cmd = term .. " -e " .. editor,

  tagnames = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
  modkey = "Mod4"
}

return _M
