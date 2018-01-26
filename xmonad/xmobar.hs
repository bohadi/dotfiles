

   -- appearance
     font =         "xft:Bitstream Vera Sans Mono:size=9:bold:antialias=true"
   , bgColor =      "black"
   , fgColor =      "#646464"
   , position =     Top
   --, alpha    =     255
   --, border =       BottomB
   --, borderColor =  "#646464"
   , sepChar =  "%"   -- delineator between plugin names and straight text
   , alignSep = "}{"  -- separator between left-right alignment



   , template = "%StdinReader% } %uptime% | %multicpu% | %memory% | %dynnetwork% { %battery% | %KNYC% |%date% "



   -- general behavior
   , lowerOnStart =     True    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest =     False   -- choose widest display (multi-monitor)
   , persistent =       True    -- enable/disable hiding (True = disabled)



   , commands = [
        -- weather monitor
        Run Weather "KNYC" [ "--template", "<fc=#4682b4><tempF></fc>°F <skyCondition>", 
                             "-L", "67", 
                             "-H", "77", 
                             "--low", "lightblue",
                             "--normal", "green",
                             "--high", "orange"
                             ] 1800
        -- network activity monitor (dynamic interface resolution)
        , Run DynNetwork     [ "--template" , "<tx>↑ <rx>↓ kB/s "
                             , "--Low"      ,   "33000"       -- units: B/s
                             , "--High"     , "1000000"      -- units: B/s
                             , "--low"      , "darkgreen"
                             , "--normal"   , "orange"
                             , "--high"     , "red"
                             ] 30
        -- cpu activity monitor
        , Run MultiCpu       [ "--template" , "<total0>·<total1>·<total2>·<total3>% cpu"
                             , "--Low"      , "20"         -- units: %
                             , "--High"     , "60"         -- units: %
                             , "--low"      , "darkgreen"
                             , "--normal"   , "orange"
                             , "--high"     , "red"
                             ] 30
        -- cpu core temperature monitor
        , Run CoreTemp       [ "--template" , "<core0> <core1> <core2> <core3>°C"
                             , "--Low"      , "70"        -- units: °C
                             , "--High"     , "80"        -- units: °C
                             , "--low"      , "darkgreen"
                             , "--normal"   , "orange"
                             , "--high"     , "red"
                             ] 100
        -- memory usage monitor
        , Run Memory         [ "--template" ,"<usedratio>% mem"
                             , "--Low"      , "75"        -- units: %
                             , "--High"     , "90"        -- units: %
                             , "--low"      , "darkgreen"
                             , "--normal"   , "orange"
                             , "--high"     , "red"
                             ] 30
        -- battery monitor
        , Run Battery        [ "--template" , "<acstatus>"
                             , "--Low"      , "17"        -- units: %
                             , "--High"     , "89"        -- units: %
                             , "--low"      , "red"
                             , "--normal"   , "grey"
                             , "--high"     , "green"
                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<fc=#7a7a39>-</fc><left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=#7a7a39>+</fc><left>% (<timeleft>)"
                                       -- charged status
                                       , "-i"	, "<fc=#00ff00>charged</fc> (<timeleft>)"
                             ] 100
        -- uptime
        , Run Uptime         ["-t", "<days>d<hours>h"
                             , "--L"        , "30"
                             , "--H"        , "90"
                             , "--low"      , "#999999"
                             , "--normal"   , "orange"
                             , "--high"     , "red"
                             ] 6000
        -- time and date indicator (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date           "<fc=#FFFFFF>%_I:%M%p</fc> %a %b %_d" "date" 10

        --, Run GMail "account" "pass" ["-t", "Mail: <count>"] 3000

        , Run StdinReader
        ]
   }
