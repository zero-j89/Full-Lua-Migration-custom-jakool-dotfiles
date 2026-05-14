hl.on("hyprland.start", function()
  hl.exec_cmd("sh -c 'sleep 3 && lact gui --startminimized &'")
  hl.exec_cmd('sh -c \'sleep 5 && openrgb --profile "helldivers" &\'')
  hl.exec_cmd("sh -c 'sleep 8 && trcc gui &'")

  -- Disabled:
  -- hl.exec_cmd('sh -c \'sleep 8 && trcc gui theme-load "Custom_zer0" &\'')
end)