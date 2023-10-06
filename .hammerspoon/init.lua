hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install=spoon.SpoonInstall


-- url redirection
function appID(app)
  return hs.application.infoForBundlePath(app)['CFBundleIdentifier']
end

safariBrowser = "com.apple.Safari"
chromeBrowser = appID('/Applications/Google Chrome.app')
braveBrowser = appID('/Applications/Brave Browser.app')
edgeBrowser = appID('/Applications/Microsoft Edge.app')
arcBrowser = 'company.thebrowser.Browser'

DefaultBrowser = arcBrowser
WorkBrowser = braveBrowser

Install:andUse("URLDispatcher",
                {
                  config = {
                    url_patterns = {
                      { "https?://.*%.atlassian%..*", WorkBrowser},
                      { "https?://.*%.descript%.com", WorkBrowser},
                      { "https?://.*%.github%.com", WorkBrowser },
                      { "https?://.*%.google%.com", WorkBrowser},
                      { "https?://.*%.notion%.so", arcBrowser },
                      { "https?://github%.com", WorkBrowser },
                      { "https?://.*scribd.*", WorkBrowser },
                      { "https?://device%.sso%.us-east-2%.amazonaws%.com", WorkBrowser},
                      { "https?://.*%.krisp%.ai", WorkBrowser },
                      { "https?://app.datadoghq.com", WorkBrowser },
                      { "https?://.*%.fastly%.com", WorkBrowser }
                    },
                    url_redir_decoders = {
-- This breaks some things
--                     { "Fix macOS double-encoding weirdness",
--                       "%%25(%x%x)",   -- This is %xx encoded, the % gets converted to %25
--                       "%%%1", true },
                      -- { "Office 365 safelinks check",
                      --   "https://eur03.safelinks.protection.outlook.com/(.*)\\?url=(.-)&.*",
                      --   "%2" },
                      -- { "MS Teams URLs",
                      --   "(https://teams.microsoft.com.*)", "msteams:%1", true },
                      --  { "Fix broken Preview anchor URLs",
                      --  "%%23", "#", false, "Preview" },
                    },
                    default_handler = DefaultBrowser
                  },
                  start = true,
                  -- loglevel = 'debug'
                }
)

--clipboard history
Install:andUse("ClipboardTool",
  {
    config = {
      paste_on_select = true,
    },
    start = true,
    hotkeys = {
      toggle_clipboard = { { "cmd", "shift" }, "v" } },
  }
)

-- window mashing
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
