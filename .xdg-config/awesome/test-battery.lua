local fh = assert(io.popen("acpi | cut -d, -f 2,3 -", "r"))
local text = fh:read("*l")
local percent = tonumber(string.match(text, "(%d+)%%"))
if (percent < 100) then
  batterywidget:set_markup(" |<span color=\"red\">" ..
                          text .. "</span> | ")
else
  batterywidget:set_text(" |" .. text .. " | ")
end
fh:close()

