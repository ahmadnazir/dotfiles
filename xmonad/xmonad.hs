-- Configuration for xmonad
--
-- Keybinding for loading the configuration: mod-q

import XMonad

-- For disabling greedy view
import qualified XMonad.StackSet as W
import qualified XMonad.Util.EZConfig as Config
import qualified XMonad.Operations as O

-- Xmobar
import XMonad.Hooks.DynamicLog

-- Fixing a problem with chrome focus
import XMonad.Hooks.EwmhDesktops

myModMask = mod4Mask

myWorkspaces :: [[Char]]
myWorkspaces = [
  "main"      -- 1
  ,"sign"     -- 2
  ,"auth"     -- 3

  ,"gateway"  -- 4
  ,"logs" -- 5
  ,"?"    -- 6
  ,"local-db"  -- 7
  ,"prod-db"       -- 8
  ,"web"      -- 9
  ,"todo"     -- 0
  ,"repl"     -- =
  -- Scratch / tmp
  ,"tmp-1"    -- [
  ,"tmp-2"    -- ]
  -- testing
  ,"api"      -- ;
  -- remote
  ,"sbx"      -- '
  ,"prd"      -- \
  ]

-- TODO: switch to screen when a key is pressed
-- myAction action tag = case tag of
--   "main" -> O.screenWorkspace 0  >>= flip whenJust (windows . W.view) >> action tag
--   "sign" -> O.screenWorkspace 1  >>= flip whenJust (windows . W.view) >> action tag
--   _      -> O.screenWorkspace 2  >>= flip whenJust (windows . W.view) >> action tag

-- Copied from
-- https://wiki.haskell.org/Xmonad/Frequently_asked_questions#Replacing_greedyView_with_view

myKeys = [
  ("M-S-l", spawn lockScreenCmd)   ,
  ("M-S-m", spawn volumeIncCmd)    ,
  ("M-S-n", spawn volumeDecCmd)    ,
  ("M-S-e", spawn enableTouchPad)  ,
  ("M-S-d", spawn disableTouchPad) ,
  ("M-S-p", spawn screenshotCmd)
  ] ++ [
  (otherModMasks ++ "M-" ++ [key], action tag) -- @todo: if key 0-5, update action so that monitor 1 is selected
  | (tag, key)  <- zip myWorkspaces "1234567890=[];'\\" ,
    (otherModMasks, action) <- [ ("", windows . W.view) , ("S-", windows . W.shift)] -- was W.greedyView
  ]

-- Layouts / Hooks
myLogHook :: X ()
myLogHook = ewmhDesktopsLogHook

-- Note: xmobar relies on the statusBar in
-- xmonad-contrib:XMonad.Hooks.DynamicLog, which specifies how the
-- status bar should contain. Maybe there is a way to remove the
-- 'layout string' e.g. Full, Tall, Mirror tall, by filtering the
-- output of xmobar defaults but I haven't looked into it
-- main = xmonad defaults -- without xmobar
main = xmonad =<< xmobar defaults

defaults = defaultConfig {
             modMask         = myModMask
           , workspaces      = myWorkspaces
           , logHook         = myLogHook -- fixes chrome focus problem

           -- How do I combine different hooks.. the hook is an IO ()
           -- action so it should be possible to combine multiple of
           -- them
           -- , logHook         = myLogHook <b> dynamicLog -- How do I combine the two?

           -- Playing with the xmobar output, apparently it doesn't
           -- have any affect
           --
           -- , logHook         = dynamicLogWithPP xmobarPP
           --                     {
           --                       -- ppOutput = hPutStrLn xmproc
           --                       ppTitle = xmobarColor "green" "" . shorten 50
           --                     }

           } `Config.additionalKeysP` myKeys

-- commands
--
-- @todo: currently xmonad doesn't recognize the custom bash scripts
-- in dotfiles so all relevant commands are listed here
--
-- @todo: some of these commands are also being used from emacs so it
-- would make sense to place them in a common place

lockScreenCmd   = "gnome-screensaver-command --lock"
volumeIncCmd    = "pactl -- set-sink-volume 0 +10%"
volumeDecCmd    = "pactl -- set-sink-volume 0 -10%"
enableTouchPad  = "xinput --enable \"SynPS/2 Synaptics TouchPad\""
disableTouchPad = "xinput --disable \"SynPS/2 Synaptics TouchPad\""
screenshotCmd    = "import -window root /tmp/`date +%s.png`"
