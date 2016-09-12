local wibox = require("wibox")
local awful = require("awful")
local theme = beautiful -- assuming it's exported globally

batteryprogresswidget = awful.widget.progressbar()
batteryprogresswidget:set_width(11)
batteryprogresswidget:set_vertical(true)
batteryprogresswidget:set_background_color(theme.bg_normal)

pbatterywidget = wibox.widget.background()
pbatterywidget:set_widget(batteryprogresswidget)

function update_battery()
  local fh = assert(io.popen("acpi -b | cut -d, -f 2,3 -", "r"))
  local text = fh:read("*l")
  fh:close()
  local percent = tonumber(string.match(text, "(%d+)%%"))
  if (percent < 10) then
    batteryprogresswidget:set_border_color(theme.border_marked)
    batteryprogresswidget:set_color(theme.border_marked)
  else
    batteryprogresswidget:set_border_color(theme.border_focus)
    batteryprogresswidget:set_color(theme.fg_normal)
  end
  batteryprogresswidget:set_value(percent/100)
end

update_battery()
local batterywidgettimer = timer({ timeout = 5 })
batterywidgettimer:connect_signal("timeout", update_battery)
batterywidgettimer:start()

