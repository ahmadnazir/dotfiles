-- Configuration for xmonad
--
-- Keybinding for loading the configuration: mod-q

import XMonad

-- For disabling greedy view
import qualified XMonad.StackSet as W
import qualified XMonad.Util.EZConfig as Config

-- Xmobar
import XMonad.Hooks.DynamicLog

-- Fixing a problem with chrome focus
import XMonad.Hooks.EwmhDesktops

myModMask = mod4Mask

myWorkspaces :: [[Char]]
myWorkspaces = ["1","2","3" -- standard workspaces (emacs and terminals)
               ,"prod"      -- live environments
               ,"s1","s2"   -- scratch
               ,"p1","p2"   -- operations
               ,"web"       -- Work related browsing
               ]

-- Copied from
-- https://wiki.haskell.org/Xmonad/Frequently_asked_questions#Replacing_greedyView_with_view
myKeys = [
        ("M-S-l", spawn lockScreenCmd)
      , ("M-S-m", spawn volumeIncCmd)
      , ("M-S-n", spawn volumeDecCmd)
      , ("M-S-e", spawn enableTouchPad)
      , ("M-S-d", spawn disableTouchPad)

     ] ++ -- (++) is needed here because the following list comprehension
          -- is a list, not a single key binding. Simply adding it to the
          -- list of key bindings would result in something like [ b1, b2,
          -- [ b3, b4, b5 ] ] resulting in a type error. (Lists must
          -- contain items all of the same type.)
     [ (otherModMasks ++ "M-" ++ [key], action tag)
       | (tag, key)  <- zip myWorkspaces "123456789"
       , (otherModMasks, action) <- [ ("", windows . W.view) -- was W.greedyView
                                       , ("S-", windows . W.shift)]
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
