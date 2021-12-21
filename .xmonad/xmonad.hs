import XMonad
import XMonad.Config.Desktop                    -- support for chrome
import XMonad.Hooks.DynamicLog                  -- xmobar
import qualified XMonad.Util.EZConfig as Config -- custom keybindings
import Graphics.X11.ExtraTypes.XF86

-- disable greedy view
import qualified XMonad.StackSet as W
import qualified XMonad.Operations as O

main = xmonad =<< xmobar defaults

defaults = desktopConfig
      {
        terminal    = "kitty"  ,
        modMask     = mod4Mask ,
        borderWidth = 1 ,
        workspaces      = map fst' workspacesAndScreens
      }
      `Config.additionalKeys` myKeys
      `Config.additionalKeysP` myKeysP
      -- `Config.removeKeysP` ["M-" ++ [x] | x <- [',', '.']]

-- Names of the keys: https://hackage.haskell.org/package/xmonad-contrib-0.16/docs/XMonad-Util-EZConfig.html

-- notImplemented msg = spawn $ "echo '[not implemented] " ++ msg ++ "' >> /tmp/xmonad-not-implemented.log"
notImplemented msg = spawn $ "dunstify '[" ++ msg ++ "] is not implemented'"

myKeysP = [
    ("M-l" , spawn "xscreensaver-command --lock") ,
    ("M-p" , spawn "dmenu_run -fn 'Monospace-14'"),
    ("M-." , spawn "dunstctl close"),
    ("S-M-." , spawn "dunstctl history-pop")
  ]
  -- disable greedy view
  ++ [ ("M-" ++ keys,   myFocus screenId tag)    | (tag, keys, screenId) <- workspacesAndScreens ]
  ++ [ ("S-M-" ++ keys, (windows . W.shift) tag) | (tag, keys, screenId) <- workspacesAndScreens ]


myKeys =
  [
    ((0 , xF86XK_AudioMute)         , notImplemented "audio mute")   ,
    ((0 , xF86XK_AudioLowerVolume)  , notImplemented "audio -")      ,
    ((0 , xF86XK_AudioRaiseVolume)  , notImplemented "audio +")      ,
    ((0 , xF86XK_AudioMicMute)      , notImplemented "mic mute")     ,

    ((0 , xF86XK_MonBrightnessDown) , notImplemented "brightness -") ,
    ((0 , xF86XK_MonBrightnessUp)   , notImplemented "brightness +") ,
    ((0 , xF86XK_Display)           , spawn "arandr")                ,
    -- skipping wifi functionality - supported natively

    ((0 , xF86XK_Tools)             , notImplemented "settings")     ,
    ((0 , xF86XK_Bluetooth)         , notImplemented "bluetooth")    ,
    -- skipping keyboard settings - don't know what the key is
    ((0 , xF86XK_Favorites)         , notImplemented "favourites")
  ]

workspacesAndScreens :: [(String, String, Int)]
workspacesAndScreens = [
  ( "me"    , "1" ,  0 ) ,
  ( "2"     , "2" ,  0 ) ,
  ( "3"     , "3" ,  0 ) ,
  ( "4"     , "4" ,  0 ) ,
  ( "5"     , "5" ,  0 ) ,
  ( "www"   , "6" ,  0 ) ,

  ( "code"  , "7" ,  1 ) ,
  ( "8"     , "8" ,  1 ) ,
  ( "9"     , "9" ,  1 ) ,
  ( "0"     , "0" ,  1 )
  ]


-- Focus a workspace to a specific screen:
-- right now the action could be anything from viewing a workpace to shift a
-- window to a workspace
myFocus screenId tag
  =
  O.screenWorkspace (S screenId)       -- Select the screen
  >>= flip whenJust (windows . W.view) -- Focus the screen
  >> (windows . W.view) tag            -- Perform the action on the screen
                                       -- (usually, focusing/shift to a
                                       -- workspace) TODO: shifting doesn't work at the
                                       -- moment

fst' (x,_,_) = x
