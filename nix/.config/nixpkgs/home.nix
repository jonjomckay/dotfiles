{ config, lib, pkgs, ... }:

{
  imports = [ ./waybar.nix ];

  home.keyboard.layout = "gb";
  home.packages = [
    pkgs.dejavu_fonts
    pkgs.fira-code
    pkgs.font-awesome
    pkgs.ipafont
    pkgs.jq
    pkgs.keepassxc
    pkgs.networkmanager-openvpn
    pkgs.python38
    pkgs.python38Packages.i3ipc
    pkgs.vscodium
  ];

  services.waybar.enable = true;
  services.waybar.package = pkgs.waybar.override {
    pulseSupport = true;
  };
  services.waybar.config = ''
{
    "layer": "top",
    "modules-left": ["sway/workspaces"],
    "modules-right": ["temperature#cpu", "temperature#gpu", "disk", "cpu", "memory", "pulseaudio", "clock"],
    "clock": {
        "format": "{:%b %d %Y, %H:%M:%S}",
        "interval": 1,
        "tooltip": false
    },
    "temperature#cpu": {
      "interval": 2,
      "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
      "critical-threshold": 80,
      "format-critical": "CPU: {temperatureC}°C ",
      "format": "CPU: {temperatureC}°C  "
    },
    "temperature#gpu": {
      "interval": 2,
      "hwmon-path": "/sys/class/hwmon/hwmon4/temp1_input",
      "critical-threshold": 80,
      "format-critical": "GPU: {temperatureC}°C ",
      "format": "GPU: {temperatureC}°C  "
    },
    "disk": {
      "interval": 10,
      "format": "{percentage_used}%  ",
      "path": "/"
    },
    "cpu": {
        "interval": 2,
        "format": "{}%  ",
        "max-length": 10
    },
    "memory": {
        "interval": 2,
        "format": "{}%  ",
        "max-length": 10
    },
    "pulseaudio": {
        "format": "{volume}%  {icon}",
        "format-bluetooth": "{volume}% {icon}",
        "format-muted": "",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", ""]
        },
        "scroll-step": 1,
        "on-click": "pavucontrol"
    },
    "sway/workspaces": {
        "disable-scroll": true,
        "all-outputs": false,
        "format": "{name}:  {icon}",
        "format-icons": {
            "1": "",
            "2": "",
            "3": "",
            "4": "",
            "5": "",
            "6": "",
            "7": "",
            "urgent": "",
            "focused": "",
            "default": ""
        }
    }
}
  '';
  services.waybar.styles = ''
* {
  background: none;
  font-size: 12px;
}

#temperature, #disk, #cpu, #memory, #pulseaudio, #clock {
  background-color: rgba(0,0,0,.7);
  border-radius: 10px;
  color: #fff;
  padding: 8px 12px;
  margin: 15px 10px 0 0;
}

#workspaces {
  margin-left: 15px;
}

#clock {
  margin-right: 15px;
}

#temperature.critical {
  color: #ff0000;
}

#pulseaudio {
  background-color: rgba(0,0,0,.7);
}

#workspaces button {
  border-radius: 10px;
  padding: 1px 8px;
  margin: 15px 5px 0 0;
  background-color: transparent;
  color: #ffffff;
  border-bottom: 3px solid transparent;
}

#workspaces button:hover {
    background: rgba(0, 0, 0, 0.2);
    box-shadow: inherit;
}

#workspaces button.focused {
    background-color: rgba(0,0,0,.7);
}

#workspaces button.urgent {
    background-color: #eb4d4b;
}
  '';

  # These are required for non-NixOS installations
  home.sessionVariables.FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
  home.sessionVariables.LD_LIBRARY_PATH = "$(nixGL printenv LD_LIBRARY_PATH):$LD_LIBRARY_PATH";
  home.sessionVariables.LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  home.sessionVariables.XDG_DATA_DIRS = "$HOME/.nix-profile/share:$HOME/.share:$XDG_DATA_DIRS:-/usr/local/share/:/usr/share";

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.feh.enable = true;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
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
      alignment = "center";
      format = "<b>%s</b>\n%b";
      geometry = "300x50-15+49";
      frame_width = 3;
      frame_color = "#8EC07C";
      horizontal_padding = 6;
      line_height = 3;
      padding = 6;
      separator_color = "frame";
      separator_height = 2;
      transparency = 5;
      word_wrap = "yes";
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

  services.network-manager-applet = {
    enable = true;
  };
  
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

  wayland.windowManager.sway.enable = true;
  wayland.windowManager.sway.config.bars = [];
  wayland.windowManager.sway.config.colors.focused = {
     border = "#007030";
     background = "#007030";
     childBorder = "#285577";
     text = "#ffffff";
     indicator = "2b2b2b";
  };
  wayland.windowManager.sway.config.colors.focusedInactive = {
     border = "#888888";
     background = "#2b2b2b";
     childBorder = "#5f676a";
     text = "#ffffff";
     indicator = "2b2b2b";
  };
  wayland.windowManager.sway.config.colors.unfocused = {
     border = "#888888";
     background = "#2b2b2b";
     childBorder = "#222222";
     text = "#ffffff";
     indicator = "2b2b2b";
  };
  wayland.windowManager.sway.config.colors.urgent = {
     border = "#900000";
     background = "#900000";
     childBorder = "#900000";
     text = "#ffffff";
     indicator = "2b2b2b";
  };
  wayland.windowManager.sway.config.gaps.inner = 15;
  wayland.windowManager.sway.config.gaps.top = 0;
  wayland.windowManager.sway.config.input = {
    "*" = {
      xkb_layout = "gb";
    };
  };
  wayland.windowManager.sway.config.modifier = "Mod4";
  wayland.windowManager.sway.config.output = {
    "*" = {
      bg = "${./anime-minimalism-4k-4e.jpg} fill";
    };
  };
  wayland.windowManager.sway.config.startup = [
    {
      command = "swaymsg workspace 1";
    }
    {
      command = "${(pkgs.python38.withPackages (ps: [ps.i3ipc])).interpreter} ${./fader.py}";
    }
  ];
  wayland.windowManager.sway.config.terminal = "kitty";
  wayland.windowManager.sway.config.window.border = 0;

  wayland.windowManager.sway.config.keybindings = let modifier = config.wayland.windowManager.sway.config.modifier;
  in lib.mkOptionDefault {
    "${modifier}+0" = "workspace number 1";
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
