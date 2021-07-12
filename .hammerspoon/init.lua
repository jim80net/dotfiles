hs.window.animationDuration = 0
units = {
  left33        = { x = 0.00, y = 0.00, w = 0.33, h = 1.00 },
  hmid33         = { x = 0.33, y = 0.00, w = 0.33, h = 1.00 },
  right33       = { x = 0.66, y = 0.00, w = 0.33, h = 1.00 },
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  left66        = { x = 0.00, y = 0.00, w = 0.66, h = 1.00 },
  right66       = { x = 0.33, y = 0.00, w = 0.66, h = 1.00 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bot50         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  upright50     = { x = 0.50, y = 0.00, w = 0.50, h = 0.50 },
  botright50    = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 },
  upleft50      = { x = 0.00, y = 0.00, w = 0.50, h = 0.50 },
  botleft50     = { x = 0.00, y = 0.50, w = 0.50, h = 0.50 },
  top33         = { x = 0.00, y = 0.00, w = 1.00, h = 0.33 },
  vmid33         = { x = 0.00, y = 0.33, w = 1.00, h = 0.33 },
  bot33         = { x = 0.00, y = 0.66, w = 1.00, h = 0.34 },
  top66         = { x = 0.00, y = 0.00, w = 1.00, h = 0.66 },
  bot66         = { x = 0.00, y = 0.33, w = 1.00, h = 0.67 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 },
  center       = { x = 0.10, y = 0.10, w = 0.80, h = 0.80 }
}

mash = { 'alt', 'ctrl', 'cmd' }
voice = hs.speech.new()
hs.hotkey.bind(mash, '1', function() hs.window.focusedWindow():move(units.upleft50,   nil, true) end)
hs.hotkey.bind(mash, '2', function() hs.window.focusedWindow():move(units.upright50,  nil, true) end)
hs.hotkey.bind(mash, '3', function() hs.window.focusedWindow():move(units.botleft50,  nil, true) end)
hs.hotkey.bind(mash, "4", function() hs.window.focusedWindow():move(units.botright50, nil, true) end)
hs.hotkey.bind(mash, ',', function() hs.window.focusedWindow():move(units.center,    nil, true) end)
hs.hotkey.bind(mash, '.', function() hs.window.focusedWindow():move(units.maximum,    nil, true) end)

hs.hotkey.bind(mash, '5', function() hs.window.focusedWindow():move(units.top33,    nil, true) end)
hs.hotkey.bind(mash, '6', function() hs.window.focusedWindow():move(units.vmid33,    nil, true) end)
hs.hotkey.bind(mash, '7', function() hs.window.focusedWindow():move(units.bot33,    nil, true) end)
hs.hotkey.bind(mash, '8', function() hs.window.focusedWindow():move(units.top66,    nil, true) end)
hs.hotkey.bind(mash, '9', function() hs.window.focusedWindow():move(units.bot66,    nil, true) end)

hs.hotkey.bind(mash, 't', function() hs.window.focusedWindow():move(units.left33,    nil, true) end)
hs.hotkey.bind(mash, 'y', function() hs.window.focusedWindow():move(units.hmid33,    nil, true) end)
hs.hotkey.bind(mash, 'u', function() hs.window.focusedWindow():move(units.right33,    nil, true) end)
hs.hotkey.bind(mash, 'i', function() hs.window.focusedWindow():move(units.left66,    nil, true) end)
hs.hotkey.bind(mash, 'o', function() hs.window.focusedWindow():move(units.right66,    nil, true) end)

hs.hotkey.bind(mash, '0', function() hs.window.focusedWindow():move(units.maximum,    nil, true) end)
hs.hotkey.bind(mash, '-', function() hs.window.focusedWindow():move(units.center,    nil, true) end)


hs.hotkey.bind(mash, 'up', function() hs.window.focusedWindow():move(units.top50,    nil, true) end)
hs.hotkey.bind(mash, 'down', function() hs.window.focusedWindow():move(units.bot50,    nil, true) end)
hs.hotkey.bind(mash, 'left', function() hs.window.focusedWindow():move(units.left50,    nil, true) end)
hs.hotkey.bind(mash, 'right', function() hs.window.focusedWindow():move(units.right50,    nil, true) end)

hs.hotkey.bind(mash, 'm', function() hs.window.focusedWindow():moveOneScreenEast(false, true) end)
hs.hotkey.bind(mash, 'n', function() hs.window.focusedWindow():moveOneScreenWest(false, true) end)

-- Somewhere along the way, cmd shift i became broadcast to all panes in all tabs, and not just the tab you are currently in
hs.hotkey.bind({'cmd', 'shift'}, 'i', function() voice:speak("use alt") end)
