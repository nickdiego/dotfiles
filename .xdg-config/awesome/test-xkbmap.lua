function update()
  local fh = assert(io.popen("setxkbmap -print", "r"))
  local text = fh:read("*all")
  fh:close()
  local l = string.match(text, "xkb_symbols.+%+(%w+).*%+")
  local n = #(kbdcfg.layout)
  for i = 1, n do
    if (kbdcfg.layout[i][1] == l) then
      kbdcfg.widget:set_text(" -- " .. kbdcfg.layout[i][3] .. " -- ")
    end
  end
end

update()
