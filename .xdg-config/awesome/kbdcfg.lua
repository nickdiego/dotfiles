local wibox = require("wibox")
local awful = require("awful")

-- Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "br", "abnt2" , "Pt-br" }, { "us", "" , "Us" } }
kbdcfg.update = function ()
  local fh = assert(io.popen("setxkbmap -print", "r"))
  local text = fh:read("*all")
  fh:close()
  local l = string.match(text, "xkb_symbols.+%+(%w+).*%+")
  for i = 1, #(kbdcfg.layout) do
    if (kbdcfg.layout[i][1] == l) then
      kbdcfg.current = i
      kbdcfg.widget:set_text(" " .. kbdcfg.layout[i][3] .. " |")
    end
  end
end

kbdcfg.widget = wibox.widget.textbox()
kbdcfg.switch = function ()
  kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
  local t = kbdcfg.layout[kbdcfg.current]
  os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
  kbdcfg.update()
end

kbdcfg.update()
kbdcfg.widget:buttons(
 awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end))
)
