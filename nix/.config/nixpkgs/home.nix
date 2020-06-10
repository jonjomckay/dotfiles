{ config, lib, pkgs, ... }:

{
  home.keyboard.layout = "gb";
  home.packages = [
    pkgs.fira-code
    pkgs.font-awesome
    pkgs.ipafont
    pkgs.jq
    pkgs.keepassxc
    pkgs.vscodium
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.firefox = {
    enable = true;
  };

  programs.git.enable = true;
  programs.git.userEmail = "jonjo@jonjomckay.com";
  programs.git.userName = "Jonjo McKay";
  programs.git.signing.key = "C4CC649D7F58611D";
  programs.git.signing.signByDefault = true;

  programs.gpg.enable = true;

  programs.keychain.enable = true;
  programs.keychain.enableXsessionIntegration = true;

  programs.kitty.enable = true;
  programs.kitty.extraConfig = ''
foreground   #c5c8c6
background   #1d1f21
cursor       #c5c8c6

! black
color0       #1d1f21
color8       #969896

! red
color1       #f393d4
color9       #ee7bca

! green
color2       #82f8b8
color10      #74faa9

! yellow
color3       #fff9b2
color11      #fffaa3

! blue
color4       #3592f4
color12      #2b7bf1

! magenta
color5       #ea60f3
color13      #e23df0

! cyan
color6       #67d5fa
color14      #58cbf9

! white
color7       #c5c8c6
color15      #ffffff

window_padding_width 0 10
  '';

  programs.rofi.enable = true;
  programs.rofi.font = "hack 10";
  programs.rofi.theme = "solarized";

  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;

  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.oh-my-zsh.enable = true;

  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      geometry = "300x50-15+49";
      frame_width = 3;
      frame_color = "#8EC07C";
      horizontal_padding = 6;
      line_height = 3;
      padding = 6;
      separator_color = "frame";
      separator_height = 2;
      transparency = 5;
    };

    urgency_low = {
      frame_color = "#3B7C87";
      foreground = "#3B7C87";
      background = "#191311";
      timeout = 4;
    };

    urgency_normal = {
      frame_color = "#5B8234";
      foreground = "#5B8234";
      background = "#191311";
      timeout = 6;
    };

    urgency_critical = {
     frame_color = "#B7472A";
      foreground = "#B7472A";
      background = "#191311";
      timeout = 8;
    };
  };

  services.gpg-agent = {
    enable = true;
  };

  services.picom.enable = true;
  services.picom.fade = true;
  # services.picom.fadeSteps = [ "0.06" "0.06" ];
  services.picom.inactiveOpacity = "0.85";
  services.picom.noDockShadow = false;
  services.picom.shadow = true;
  # services.picom.shadowOffsets = [ -6 -6 ];
  services.picom.shadowOpacity = ".75";
  services.picom.vSync = true;

  services.polybar.enable = true;
  services.polybar.package = pkgs.polybar.override {
    i3GapsSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };
  services.polybar.extraConfig = ''
;==========================================================
;
;
;   ██████╗  ██████╗ ██╗  ██╗   ██╗██████╗  █████╗ ██████╗
;   ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗
;   ██████╔╝██║   ██║██║   ╚████╔╝ ██████╔╝███████║██████╔╝
;   ██╔═══╝ ██║   ██║██║    ╚██╔╝  ██╔══██╗██╔══██║██╔══██╗
;   ██║     ╚██████╔╝███████╗██║   ██████╔╝██║  ██║██║  ██║
;   ╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
;
;
;   To learn more about how to configure Polybar
;   go to https://github.com/polybar/polybar
;
;   The README contains a lot of information
;
;==========================================================

[colors]

background = ''${xrdb:color0:#222}
color1 = ''${xrdb:color2}
color2 = ''${xrdb:color4}
color3 = ''${xrdb:color6}

;  _                    
; | |__   __ _ _ __ ___ 
; | '_ \ / _` | '__/ __|
; | |_) | (_| | |  \__ \
; |_.__/ \__,_|_|  |___/

[bar/base]
font-0=DejaVu Sans Mono:size=10:antialias=true;3
font-1=FontAwesome5Free:style=Regular:size=9:antialias=true;3
font-2=FontAwesome5Free:style=Solid:size=9:antialias=true;3
font-3=IPAGothic:style=Regular:size=11:antialias=true;3


height = 32
;radius = 10
; TODO: Get this to work with shadows... it uses the background color for the bits outside the radius :(

background = ''${colors.background}
override-redirect=true
offset-y = 10

;wm-restack = i3

[bar/i3]
inherit = bar/base
width = 35%

foreground = ''${colors.color1}

offset-x = 15


modules-left = i3 wsnumber xwindow

scroll-up = i3wm-wsnext
scroll-down = i3wm-wsprev


[bar/music]
inherit = bar/base
enable-ipc = true
width = 28%

foreground = ''${colors.color2}
offset-x = 55.5%

; Spotify (script at github.com/dietervanhoof/polybar-spotify-controls)
;modules-left = previous playpause next spotify
; Mpd
modules-left = mpd

[bar/tray]
inherit = bar/base
width = 300

padding-right = 0
offset-x = 2245

modules-left = pulseaudio time power

;                      _       _           
;  _ __ ___   ___   __| |_   _| | ___  ___ 
; | '_ ` _ \ / _ \ / _` | | | | |/ _ \/ __|
; | | | | | | (_) | (_| | |_| | |  __/\__ \
; |_| |_| |_|\___/ \__,_|\__,_|_|\___||___/
                                         
[module/wsnumber]
type = custom/script
exec = ~/.config/polybar/themes-blocks/get_workspace
tail = true
interval = 0
format = "<label>  "
format-padding = 0
format-foreground = ''${colors.background}
format-background = ''${colors.color1}
scroll-up = i3 workspace next
scroll-down = i3 workspace prev


[module/xwindow]
type = internal/xwindow
label = %title:0:100:...%
label-foreground = ''${colors.color1} 
label-background = ''${colors.background} 
label-padding = 2

[module/i3]
type = internal/i3
format = <label-state> <label-mode>
format-padding = 1
format-background = ''${colors.color1}
format-foreground = ''${colors.background}
index-sort = true
wrapping-scroll = false

enable-click = true
reverse-scroll = false

label-focused = 
label-focused-font = 3
label-focused-foreground = ''${colors.background}
label-focused-padding = 1

label-unfocused = 
label-unfocused-font = 2
label-unfocused-padding = 1
label-unfocused-foreground = ''${colors.background}

label-urgent = 
label-urgent-font = 1
label-urgent-padding = 1
label-urgent-foreground = ''${colors.background}

;ws-icon-0 = 1;
;ws-icon-1 = 2;
;ws-icon-2 = 3;
;ws-icon-9 = 10;
;ws-icon-default = 

[module/power]
type = custom/text
content = 
content-foreground = ''${colors.color3}
click-left = powermenu
content-padding = 2

[module/mpd]
type = internal/mpd
host = 127.0.0.1
port = 6600
format-online =  <icon-prev> <toggle> <icon-next>  <label-song><label-time>
format-online-padding = 2
format-online-background = ''${colors.color2}
format-online-foreground = ''${colors.background}
label-song-foreground = ''${colors.color2}
label-song-background = ''${colors.background}
label-song-padding = 2
label-time-foreground = ''${colors.color2}
label-time-background = ''${colors.background}
label-time-padding = 1

format-offline = <label-offline>
label-offline =  offline
format-offline-padding = 2
format-offline-foreground = ''${colors.color2}
format-offline-background = ''${colors.background}

bar-progress-width = 35
bar-progress-indicator = |
bar-progress-fill = ─
bar-progress-empty = ─

icon-prev = 
icon-stop = 
icon-play = 
icon-pause = 
icon-next = 

label-song-maxlen = 38
label-song-ellipsis = true

[module/time]
type = internal/date
interval = 1
format-margin = 2

time = "%H:%M:%S"
date = "%d %b"

label = %date%, %time%
label-foreground = ''${colors.color3}
label-background = ''${colors.background}

[module/pulseaudio]
type = internal/pulseaudio

format-volume-padding = 2
format-volume = <ramp-volume> <label-volume>
label-volume = %percentage:3:3%%
format-volume-background = ''${colors.color3}
format-volume-foreground = ''${colors.background}
use-ui-max = false
interval = 5

ramp-volume-0 = ""
ramp-volume-1 = ""
ramp-volume-2 = ""


label-muted = "    "   
label-muted-background = ''${colors.background}
label-muted-foreground = ''${colors.color3}
label-muted-padding = 2

;Spotify modules

[module/previous]
type = custom/script
format-font = 3
format-padding = 2
format-background = ''${colors.color2}
format-foreground = ''${colors.background}
exec = echo "  "
exec-if = "pgrep spotify"
click-left = "playerctl previous"


[module/next]
type = custom/script
format-font = 3
format-padding = 2
format-background = ''${colors.color2}
format-foreground = ''${colors.background}
exec = echo "  "
exec-if = "pgrep spotify"
click-left = "playerctl next"

[module/playpause]
type = custom/script
exec = spotifystatus
exec-if = "pgrep spotify"
format-font = 3
format-background = ''${colors.color2}
format-foreground = ''${colors.background}
format-padding = 1
tail = true
interval = 0
click-left = "playerctl -p spotify play-pause"


[module/spotify]
type = custom/script
exec = playerctl -p spotify metadata --format '{{artist}}: {{title}}'
exec-if = "pgrep spotify"
format-padding = 2
tail = true
interval = 1

[settings]
screenchange-reload = true
;compositing-background = xor
;compositing-background = screen
;compositing-foreground = source
;compositing-border = over
;pseudo-transparency = true

[global/wm]
margin-top = 0
margin-bottom = 0

; vim:ft=dosini
  '';
  services.polybar.script = ''
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# polybar -rq dummy & 
polybar -rq music &
polybar -rq tray &
polybar -rq i3 &

  '';

  services.syncthing.enable = true;

  xresources.extraConfig = ''
! special
*.foreground:   #c5c8c6
*.background:   #1d1f21
*.cursorColor:  #c5c8c6

! black
*.color0:       #1d1f21
*.color8:       #969896

! red
*.color1:       #f393d4
*.color9:       #ee7bca

! green
*.color2:       #82f8b8
*.color10:      #74faa9

! yellow
*.color3:       #fff9b2
*.color11:      #fffaa3

! blue
*.color4:       #3592f4
*.color12:      #2b7bf1

! magenta
*.color5:       #ea60f3
*.color13:      #e23df0

! cyan
*.color6:       #67d5fa
*.color14:      #58cbf9

! white
*.color7:       #c5c8c6
*.color15:      #ffffff
  '';

  xsession.enable = true;
  xsession.scriptPath = ".hm-xsession";
  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.config.bars = [];
  xsession.windowManager.i3.config.colors.focused = {
     border = "#007030";
     background = "#007030";
     childBorder = "#285577";
     text = "#ffffff";
     indicator = "2b2b2b";
  };
  xsession.windowManager.i3.config.colors.focusedInactive = {
     border = "#888888";
     background = "#2b2b2b";
     childBorder = "#5f676a";
     text = "#ffffff";
     indicator = "2b2b2b";
  };
  xsession.windowManager.i3.config.colors.unfocused = {
     border = "#888888";
     background = "#2b2b2b";
     childBorder = "#222222";
     text = "#ffffff";
     indicator = "2b2b2b";
  };
  xsession.windowManager.i3.config.colors.urgent = {
     border = "#900000";
     background = "#900000";
     childBorder = "#900000";
     text = "#ffffff";
     indicator = "2b2b2b";
  };
  xsession.windowManager.i3.config.gaps.top = 40;
  xsession.windowManager.i3.config.modifier = "Mod4";
  xsession.windowManager.i3.config.terminal = "kitty";
  xsession.windowManager.i3.config.window.commands = [
    {
      command = "border pixel 0";
      criteria = { class = ".*"; };
    }
    {
      command = "gaps inner all set 15";
      criteria = { class = ".*"; };
    }
    {
      command = "gaps horizontal current minus 10";
      criteria = { class = ".*"; };
    }
  ];

  xsession.windowManager.i3.config.keybindings = let modifier = config.xsession.windowManager.i3.config.modifier;
  in lib.mkOptionDefault {
    "${modifier}+space" = "exec rofi -show drun";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
