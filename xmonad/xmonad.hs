import XMonad

-- For disabling greedy view
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

-- Xmobar
import XMonad.Hooks.DynamicLog

myModMask = mod4Mask

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

-- Copied from
-- https://wiki.haskell.org/Xmonad/Frequently_asked_questions#Replacing_greedyView_with_view
myKeys = [
    -- other additional keys
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

main = xmonad =<< xmobar defaults

defaults = defaultConfig {
    modMask    = myModMask,
    workspaces = myWorkspaces
  } `additionalKeysP` myKeys

