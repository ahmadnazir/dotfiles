import XMonad
import XMonad.Config.Desktop

main = xmonad desktopConfig
      { terminal    = "xterm"
      , modMask     = mod4Mask
      , borderWidth = 3
      }
