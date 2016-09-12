local wibox = require("wibox")

batterywidget = wibox.widget.textbox()
batterywidget:set_text(" | Battery | ")
batterywidgettimer = timer({ timeout = 5 })
batterywidgettimer:connect_signal("timeout",
  function()
    local fh = assert(io.popen("acpi -b | cut -d, -f 2,3 -", "r"))
    local text = fh:read("*l")
    local percent = tonumber(string.match(text, "(%d+)%%"))
    if (percent < 10) then
      batterywidget:set_markup(" |<span color=\"red\">" ..
                              text .. "</span> | ")
    else
      batterywidget:set_text(" |" .. text .. " | ")
    end
    fh:close()
  end
)
batterywidgettimer:start()
