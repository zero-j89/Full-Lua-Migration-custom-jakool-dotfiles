local home = os.getenv("HOME")


hl.on("hyprland.start", function()
   hl.exec_cmd('openrgb --startminimized --profile "helldivers"')
   hl.exec_cmd(dropterm)
   hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/UserScripts/RainbowBorders.sh restore")
end)

-- end)

 --  hl.exec_cmd("sh -c 'sleep 3 && lact gui --startminimized &'")
 --  hl.exec_cmd('sh -c \'sleep 5 && openrgb --profile "helldivers" &\'')

  -- Disabled:
  --  hl.exec_cmd('sh -c \'sleep 8 && trcc gui theme-load "Custom_zer0" &\'')

