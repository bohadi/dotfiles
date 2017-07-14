--------------------------------------------------------------------------------
-- | xmonad.hs
--
module Main (main) where

--------------------------------------------------------------------------------
import System.Exit
import XMonad
import XMonad.Config.Desktop
--import XMonad.Wallpaper -- just use feh
import XMonad.ManageHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.BinarySpacePartition (emptyBSP)
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.ResizableTile (ResizableTall(..))
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Shell
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.Scratchpad
import XMonad.StackSet (RationalRect(..))
import XMonad.Util.WorkspaceCompare (getSortByIndex)


--------------------------------------------------------------------------------
main = do
  --spawn "pkill xmobar"
  handle <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
  --setRandomWallpaper ["$HOME/.xmonad/wallpapers"]

  -- Start xmonad using the main desktop configuration with a few
  -- simple overrides:
  xmonad $ desktopConfig { 
    --modMask    = mod4Mask -- Use "Win" not Alt for the mod key
    --terminal   = "terminator"
      manageHook = myManageHook <+> manageHook desktopConfig <+> scratchpadManageHook (RationalRect 0.55 0.57 0.4 0.35)
    , layoutHook = desktopLayoutModifiers $ myLayouts
    --, logHook    = dynamicLogString def >>= xmonadPropLog
    , workspaces = ["1", "2", "3", "4", "5", "6"]
    , logHook = dynamicLogWithPP xmobarPP
                    { ppOutput  = hPutStrLn handle
                    , ppCurrent = xmobarColor "cyan" "" . wrap "[" "]"
                    , ppTitle   = xmobarColor "dimgrey" "" . shorten 50
                    , ppHidden  = xmobarColor "darkcyan" ""
                    , ppHiddenNoWindows = xmobarColor "grey" ""
                    , ppSep     = "‖"
                    , ppWsSep   = " "
                    --, ppLayout  = id
                    , ppOrder   = \(ws:_:t:_) -> [ws,t] -- omit layout/other loggers
                    , ppSort = fmap (.scratchpadFilterOutWorkspace) getSortByIndex -- filter NSP ws
                    }
    }

    `additionalKeysP` -- Add some extra key bindings:
        [   ("M-<Space>"    , sendMessage (Toggle "Full"))
          , ("M-s"          , scratchpadSpawnActionTerminal "xterm")
          , ("M-<F4>"       , kill)
        --, ("M-="          , spawn "xterm")
        --, ("M-\\"         , spawn "chromium")
        --, ("M-<F1>"       , spawn "sudo slock")
        ]

--------------------------------------------------------------------------------
-- | Customize layouts.
--
-- This layout configuration uses two primary layouts, 'ResizableTall'
-- and 'BinarySpacePartition'.
myLayouts = toggleLayouts (noBorders Full) others
  where
    others = ResizableTall 1 (1.5/100) (3/5) [] ||| emptyBSP

--------------------------------------------------------------------------------
-- | Manipulate windows as they are created.  The list given to
-- @composeOne@ is processed from top to bottom.  The first matching
-- rule wins.
-- Use the `xprop' tool to get the info you need for these matches.
-- For className, use the second value that xprop gives you.
myManageHook = composeOne
  [ className =? "gcolor2"        -?> doFloat
  , className =? "crawl-tiles"    -?> doFloat
  , isDialog                      -?> doCenterFloat
    -- Move transient windows to their parent:
  , transience
  ]
