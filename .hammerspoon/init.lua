hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install=spoon.SpoonInstall


-- url redirection
function appID(app)
  return hs.application.infoForBundlePath(app)['CFBundleIdentifier']
end

safariBrowser = "com.apple.Safari"
chromeBrowser = appID('/Applications/Google Chrome.app')
--braveBrowser = appID('/Applications/Brave Browser.app')
--edgeBrowser = appID('/Applications/Microsoft Edge.app')
arcBrowser = 'company.thebrowser.Browser'

DefaultBrowser = chromeBrowser
WorkBrowser = chromeBrowser

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

-- Function to add query parameter to Teams URLs
local function addQueryParam(url)
  local separator = url:find("?") and "&" or "?"
  return url .. separator .. "clipboardrewritesuccess=true"
end

-- Monitor clipboard for teams urls and rewrite them to eliminate the extra noise on paste.
local pasteboardWatcher = hs.pasteboard.watcher.new(function()
  local clipboardContents = hs.pasteboard.getContents()
  if clipboardContents then
      if clipboardContents:match("^https://teams%.microsoft%.com/") and not clipboardContents:match("[&?]clipboardrewritesuccess=true") then
          local modifiedURL = addQueryParam(clipboardContents)
          hs.pasteboard.setContents(modifiedURL)
      end
  end
end)

-- Start the clipboard watcher
pasteboardWatcher:start()


-- window mashing
hs.window.animationDuration = 0
units = {

  upleft50      = { x = 0.00, y = 0.00, w = 0.50, h = 0.50 },
  upright50     = { x = 0.50, y = 0.00, w = 0.50, h = 0.50 },
  botleft50     = { x = 0.00, y = 0.50, w = 0.50, h = 0.50 },
  botright50    = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 },
  upleft76      = { x = 0.00, y = 0.00, w = 0.76, h = 0.76 },
  upright76     = { x = 0.26, y = 0.02, w = 0.74, h = 0.76 },
  botleft76     = { x = 0.00, y = 0.26, w = 0.76, h = 0.74 },
  botright76    = { x = 0.24, y = 0.24, w = 0.76, h = 0.76 },
  upleft86      = { x = 0.00, y = 0.00, w = 0.86, h = 0.86 },
  upright86     = { x = 0.16, y = 0.02, w = 0.84, h = 0.86 },
  botleft86     = { x = 0.00, y = 0.16, w = 0.86, h = 0.84 },
  botright86    = { x = 0.14, y = 0.14, w = 0.86, h = 0.86 },

  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  bot50         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  left76        = { x = 0.00, y = 0.00, w = 0.76, h = 1.00 },
  bot76         = { x = 0.00, y = 0.24, w = 1.00, h = 0.76 },
  top76         = { x = 0.00, y = 0.00, w = 1.00, h = 0.76 },
  right76       = { x = 0.24, y = 0.00, w = 0.76, h = 1.00 },
  left86        = { x = 0.00, y = 0.00, w = 0.86, h = 1.00 },
  bot86         = { x = 0.00, y = 0.14, w = 1.00, h = 0.86 },
  top86         = { x = 0.00, y = 0.00, w = 1.00, h = 0.86 },
  right86       = { x = 0.14, y = 0.00, w = 0.86, h = 1.00 },

  center       = { x = 0.07, y = 0.07, w = 0.86, h = 0.86 },
  centerwide       = { x = 0.04, y = 0.05, w = 0.92, h = 0.90 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 },
}

mash = { 'alt', 'ctrl', 'cmd' }
voice = hs.speech.new()
hs.hotkey.bind(mash, '1', function() hs.window.focusedWindow():move(units.upleft50,   nil, true) end)
hs.hotkey.bind(mash, '2', function() hs.window.focusedWindow():move(units.upright50,  nil, true) end)
hs.hotkey.bind(mash, '3', function() hs.window.focusedWindow():move(units.botleft50,  nil, true) end)
hs.hotkey.bind(mash, "4", function() hs.window.focusedWindow():move(units.botright50, nil, true) end)

hs.hotkey.bind(mash, 'q', function() hs.window.focusedWindow():move(units.upleft76,   nil, true) end)
hs.hotkey.bind(mash, 'w', function() hs.window.focusedWindow():move(units.upright76,  nil, true) end)
hs.hotkey.bind(mash, 'e', function() hs.window.focusedWindow():move(units.botleft76,  nil, true) end)
hs.hotkey.bind(mash, "r", function() hs.window.focusedWindow():move(units.botright76, nil, true) end)

hs.hotkey.bind(mash, 'a', function() hs.window.focusedWindow():move(units.upleft86,   nil, true) end)
hs.hotkey.bind(mash, 's', function() hs.window.focusedWindow():move(units.upright86,  nil, true) end)
hs.hotkey.bind(mash, 'd', function() hs.window.focusedWindow():move(units.botleft86,  nil, true) end)
hs.hotkey.bind(mash, "f", function() hs.window.focusedWindow():move(units.botright86, nil, true) end)

hs.hotkey.bind(mash, '0', function() hs.window.focusedWindow():move(units.center,    nil, true) end)
hs.hotkey.bind(mash, '-', function() hs.window.focusedWindow():move(units.centerwide,    nil, true) end)
hs.hotkey.bind(mash, '=', function() hs.window.focusedWindow():move(units.maximum,    nil, true) end)

hs.hotkey.bind(mash, '6', function() hs.window.focusedWindow():move(units.left50,    nil, true) end)
hs.hotkey.bind(mash, '7', function() hs.window.focusedWindow():move(units.bot50,    nil, true) end)
hs.hotkey.bind(mash, '8', function() hs.window.focusedWindow():move(units.top50,    nil, true) end)
hs.hotkey.bind(mash, '9', function() hs.window.focusedWindow():move(units.right50,    nil, true) end)

hs.hotkey.bind(mash, 'y', function() hs.window.focusedWindow():move(units.left76,    nil, true) end)
hs.hotkey.bind(mash, 'u', function() hs.window.focusedWindow():move(units.bot76,    nil, true) end)
hs.hotkey.bind(mash, 'i', function() hs.window.focusedWindow():move(units.top76,    nil, true) end)
hs.hotkey.bind(mash, 'o', function() hs.window.focusedWindow():move(units.right76,    nil, true) end)

hs.hotkey.bind(mash, 'h', function() hs.window.focusedWindow():move(units.left86,    nil, true) end)
hs.hotkey.bind(mash, 'j', function() hs.window.focusedWindow():move(units.bot86,    nil, true) end)
hs.hotkey.bind(mash, 'k', function() hs.window.focusedWindow():move(units.top86,    nil, true) end)
hs.hotkey.bind(mash, 'l', function() hs.window.focusedWindow():move(units.right86,    nil, true) end)


hs.hotkey.bind(mash, 'left', function() hs.window.focusedWindow():moveOneScreenWest(false, true) end)
hs.hotkey.bind(mash, 'down', function() hs.window.focusedWindow():moveOneScreenSouth(false, true) end)
hs.hotkey.bind(mash, 'up', function() hs.window.focusedWindow():moveOneScreenNorth(false, true) end)
hs.hotkey.bind(mash, 'right', function() hs.window.focusedWindow():moveOneScreenEast(false, true) end)

-- Somewhere along the way, cmd shift i became broadcast to all panes in all tabs, and not just the tab you are currently in
hs.hotkey.bind({'cmd', 'shift'}, 'i', function() voice:speak("use alt") end)

