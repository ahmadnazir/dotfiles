-- Configuration for xmonad
--
-- Keybinding for loading the configuration: mod-q

import XMonad

-- For disabling greedy view
import qualified XMonad.StackSet as W
import qualified XMonad.Util.EZConfig as Config
import qualified XMonad.Operations as O

import qualified Data.Map as M
import System.Exit

-- Xmobar
import XMonad.Hooks.DynamicLog

-- Fixing a problem with chrome focus
import XMonad.Hooks.EwmhDesktops

import Data.Char

import Debug.Trace

myModMask = mod4Mask

myWorkspaces :: [(String, String)]
myWorkspaces = [
  ( "me"       ,"`" ) ,
  ( "teams"    ,"1" ) ,
  ( "mail"     ,"2" ) ,
  ( "brp"      ,"3" ) ,
  ( "azure"    ,"4" ) ,
  ( "search"   ,"5" ) ,
  ( "6"        ,"6" ) ,
  ( "code"     ,"7" ) ,
  ( "8"        ,"8" ) ,
  ( "9"        ,"9" ) ,
  ( "0"        ,"0" )

  ]

   -- [((m .|. modm, k), windows $ f i)
   --      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
   --      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-- focus a workspace to a specific screen
-- right now the action could be anything from viewing a workpace to shift a window to a workspace
myFocus tag = (windows . W.greedyView) tag

-- Copied (and modified) from
-- https://wiki.haskell.org/Xmonad/Frequently_asked_questions#Replacing_greedyView_with_view

myKeys = [
    ("M-S-l", spawn lockScreenCmd)   ,
    ("M-S-m", spawn volumeIncCmd)    ,
    ("M-S-n", spawn volumeDecCmd)    ,
    ("M-S-p", spawn screenshotCmd)
  ]
  ++ [ ("M-" ++ keys,   myFocus tag)    | (tag, keys) <- myWorkspaces ]
  ++ [ ("S-M-" ++ keys, (windows . W.shift) tag) | (tag, keys) <- myWorkspaces]


help :: String
help = "I, mandark, have overridden the default keybindings. Check the config to see the keybindings."

-- | The xmonad key bindings. Add, modify or remove key bindings here.
--
-- (The comment formatting character is used when generating the manpage)
--
defaultKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
defaultKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((modMask,               xK_p     ), spawn "dmenu_run") -- %! Launch dmenu
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun") -- %! Launch gmrun
    , ((modMask .|. shiftMask, xK_c     ), kill) -- %! Close the focused window

    , ((modMask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    , ((modMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
    , ((modMask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((modMask,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((modMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((modMask              , xK_q     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad

    , ((modMask .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -")) -- %! Run xmessage with a summary of the default keybindings (useful for beginners)
    -- repeat the binding for non-American layout keyboards
    , ((modMask              , xK_question), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]


-- -- Layouts / Hooks
-- myLogHook :: X ()
-- myLogHook = ewmhDesktopsLogHook

fst' (x,_,_) = x

-- Note: xmobar relies on the statusBar in
-- xmonad-contrib:XMonad.Hooks.DynamicLog, which specifies how the
-- status bar should contain. Maybe there is a way to remove the
-- 'layout string' e.g. Full, Tall, Mirror tall, by filtering the
-- output of xmobar defaults but I haven't looked into it
-- main = xmonad defaults -- without xmobar
main = xmonad =<< xmobar defaults

defaults = defaultConfig {
             modMask         = myModMask
           , workspaces      = map fst myWorkspaces
           -- , logHook         = myLogHook -- fixes chrome focus problem
           , keys            = defaultKeys
           , terminal        = "gnome-terminal"

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
screenshotCmd   = "import -window root /tmp/`date +%s.png`"
