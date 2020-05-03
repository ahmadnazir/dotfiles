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

workspacesAndScreens :: [(String, String, Int)]
workspacesAndScreens = [
  ( "me"       ,"`",   0 ) ,
  ( "teams"    ,"1",   0 ) ,
  ( "mail"     ,"2",   0 ) ,
  ( "brp"      ,"3",   0 ) ,
  ( "azure"    ,"4",   0 ) ,
  ( "search"   ,"5",   0 ) ,
  ( "6"        ,"6",   0 ) ,
  ( "code"     ,"7",   1 ) ,
  ( "8"        ,"8",   1 ) ,
  ( "9"        ,"9",   1 ) ,
  ( "0"        ,"0",   1 ) ,
  ( "scrib"    ,",",   1 ) ,
  ( "notes"    ,".",   1 )

  ]

-- focus a workspace to a specific screen
-- right now the action could be anything from viewing a workpace to shift a window to a workspace
myFocus screenId tag
  =
  O.screenWorkspace (S screenId) -- Select the screen
  >>= flip whenJust (windows . W.view) -- Focus the screen
  >> (windows . W.view) tag -- perform the action on the screen (usually, focusing/shift to a workspace)
                -- TODO: shifting doesn't work at the moment

-- Copied (and modified) from
-- https://wiki.haskell.org/Xmonad/Frequently_asked_questions#Replacing_greedyView_with_view

myKeys = [
    -- ("M-S-s", spawn suspendCmd)   ,
    ("M-S-l", spawn lockScreenCmd)   ,
    ("M-S-m", spawn volumeIncCmd)    ,
    ("M-S-n", spawn volumeDecCmd)    ,
    -- ("M-S-e", spawn enableTouchPad)  ,
    -- ("M-S-d", spawn disableTouchPad) ,
    ("M-S-p", spawn screenshotCmd)
  ]
  ++ [ ("M-" ++ keys,   myFocus screenId tag)    | (tag, keys, screenId) <- workspacesAndScreens ]
  ++ [ ("S-M-" ++ keys, (windows . W.shift) tag) | (tag, keys, screenId) <- workspacesAndScreens ]


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

    -- My modifications

    -- ++
    -- -- mod-[1..9] %! Switch to workspace N
    -- -- mod-shift-[1..9] %! Move client to workspace N
    -- [((m .|. modMask, k), windows $ f i)
    --     | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    ++
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e] [0,1]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- Layouts / Hooks
myLogHook :: X ()
myLogHook = ewmhDesktopsLogHook

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
           , workspaces      = map fst' workspacesAndScreens
           , logHook         = myLogHook -- fixes chrome focus problem
           , keys            = defaultKeys
           , terminal        = "gnome-terminal"

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
suspendCmd      = "sudo pm-suspend"
volumeIncCmd    = "pactl -- set-sink-volume 0 +10%"
volumeDecCmd    = "pactl -- set-sink-volume 0 -10%"
enableTouchPad  = "xinput --enable \"SynPS/2 Synaptics TouchPad\""
disableTouchPad = "xinput --disable \"SynPS/2 Synaptics TouchPad\""
screenshotCmd   = "import -window root /tmp/`date +%s.png`"
