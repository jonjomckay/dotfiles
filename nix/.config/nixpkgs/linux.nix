{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.bmon
    pkgs.brightnessctl
    pkgs.gnome3.gnome-calculator
    pkgs.gnome3.gnome-screenshot
    pkgs.grim
    pkgs.iotop
    pkgs.keepassxc
    pkgs.meld
    pkgs.networkmanager-openvpn
    pkgs.pulsemixer
    pkgs.python38
    pkgs.python38Packages.i3ipc
    pkgs.slack
    pkgs.slurp
    pkgs.xdg-user-dirs
    pkgs.yarn
  ];

  home.sessionVariables.LD_LIBRARY_PATH = "$(nixGL printenv LD_LIBRARY_PATH):$LD_LIBRARY_PATH";
  home.sessionVariables.LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  # This is only required because the gnome-keyring service doesn't seem to set it properly yet
  home.sessionVariables.SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";

  programs.feh.enable = true;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
  };

  programs.ncmpcpp.enable = true;

  programs.rofi.enable = true;
  programs.rofi.font = "Fira Code Retina 10";
  programs.rofi.theme = "solarized";
  programs.rofi.extraConfig = ''
    rofi.show-icons: true
  '';

  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscodium;
  programs.vscode.extensions = [
    pkgs.vscode-extensions.bbenoist.Nix
  ];
  programs.vscode.userSettings = {
    "debug.console.fontSize" = 12;
    "editor.fontFamily" = "'Fira Code Retina'";
    "editor.fontSize" = 12;
    "editor.minimap.enabled" = false;
    "markdown.preview.fontSize" = 12;
    "terminal.integrated.fontSize" = 12;
  };

  programs.zsh.initExtra = ''
  if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec nixGL sway
  fi
  '';

  services.blueman-applet.enable = true;

  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      alignment = "center";
      follow = "mouse";
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

  services.gnome-keyring.enable = true;
  services.gnome-keyring.components = ["pkcs11" "secrets" "ssh"];

  services.gpg-agent = {
    enable = true;
  };

  services.mpd.enable = true;
  services.mpd.musicDirectory = "/mnt/music";

  services.mpdris2.enable = true;

  services.network-manager-applet = {
    enable = true;
  };
  
  services.syncthing.enable = true;

  services.waybar.enable = true;
  services.waybar.package = pkgs.waybar.override {
    pulseSupport = true;
  };
  # services.waybar.config = builtins.readFile ./configs/waybar.json;
  services.waybar.styles = builtins.readFile ./configs/waybar.css;

  services.waybar.extraConfig = {
    layer = "top";
    
    modules-left = ["sway/workspaces"];
    modules-right = ["custom/waybar-media" "temperature#cpu" "temperature#gpu" "disk" "cpu" "memory" "pulseaudio" "tray" "clock"];
    
    clock = {
      format = "{:%b %d %Y, %H:%M:%S}";
      interval = 1;
      tooltip = false;
    };
    
    "custom/waybar-media" = {
      return-type = "json";
      exec = "${(pkgs.python38.withPackages (ps: [ps.pydbus ps.psutil])).interpreter} ${./waybar-media.py} status";
      on-click = "${(pkgs.python38.withPackages (ps: [ps.pydbus ps.psutil])).interpreter} ${./waybar-media.py} playpause";
      on-scroll-up = "${(pkgs.python38.withPackages (ps: [ps.pydbus ps.psutil])).interpreter} ${./waybar-media.py} previous";
      on-scroll-down = "${(pkgs.python38.withPackages (ps: [ps.pydbus ps.psutil])).interpreter} ${./waybar-media.py} next";
      escape = true;
    };

    "temperature#cpu" = {
      interval = 2;
      hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
      critical-threshold = 80;
      format-critical = " CPU: {temperatureC}°C";
      format = " CPU: {temperatureC}°C";
    };

    "temperature#gpu" = {
      interval = 2;
      hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
      critical-threshold = 80;
      format-critical = " GPU: {temperatureC}°C";
      format = " GPU: {temperatureC}°C";
    };

    "disk" = {
      interval = 10;
      format = " {percentage_used}%";
      path = "/";
    };

    "cpu" = {
        interval = 2;
        format = " {}%";
        max-length = 10;
    };

    "memory" = {
        interval = 2;
        format = " {}%";
        max-length = 10;
    };

    "pulseaudio" = {
        format = "{icon} {volume}%";
        format-bluetooth = "{icon}  {volume}%";
        format-muted = "";
        format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" ""];
        };
        scroll-step = 1;
        on-click = "pavucontrol";
    };

    "tray" = {
      icon-size = "21";
      spacing = 10;
    };

    "sway/workspaces" = {
      disable-scroll = true;
      all-outputs = false;
      format = "{name}:  {icon}";
      format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "";
          "7" = "";
          urgent = "";
          focused = "";
          default = "";
      };
    };
  };

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

    "2:10:TPPS/2_Elan_TrackPoint" = {
      pointer_accel = "0.1";
    };

    "2:7:SynPS/2_Synaptics_TouchPad" = {
      accel_profile = "adaptive";
      click_method = "button_areas";
      natural_scroll = "enabled";
      pointer_accel = "0.6";
      tap = "enabled";
    };

    "1452:635:bcm5974" = {
      accel_profile = "adaptive";
      click_method = "button_areas";
      natural_scroll = "enabled";
      pointer_accel = "0.55";
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
  wayland.windowManager.sway.config.terminal = "nixGL alacritty";
  wayland.windowManager.sway.config.window.border = 0;

  wayland.windowManager.sway.config.keybindings = let modifier = config.wayland.windowManager.sway.config.modifier;
  in lib.mkOptionDefault {
    "${modifier}+0" = "workspace number 1";
    "${modifier}+space" = "exec rofi -show drun";
    "Print" = "exec grim -g \"$(slurp; sleep 5)\" $(xdg-user-dir PICTURES)/$(date +'%s_grim.png')";
    "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
    "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
    "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
    "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
    "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
    "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
    "XF86AudioPlay" = "exec playerctl play-pause";
    "XF86AudioNext" = "exec playerctl next";
    "XF86AudioPrev" = "exec playerctl previous";
  };

  xresources.extraConfig = builtins.readFile ./configs/xresources.conf;
}
