{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.blueman
    pkgs.bmon
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
  ];

  home.sessionVariables.LD_LIBRARY_PATH = "$(nixGL printenv LD_LIBRARY_PATH):$LD_LIBRARY_PATH";
  home.sessionVariables.LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  programs.feh.enable = true;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
  };

  programs.keychain.enable = true;
  programs.keychain.enableXsessionIntegration = true;

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
    "editor.fontFamily" = "'Fira Code'";
    "editor.fontSize" = 12;
    "editor.minimap.enabled" = false;
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

  services.gpg-agent = {
    enable = true;
  };

  services.network-manager-applet = {
    enable = true;
  };
  
  services.syncthing.enable = true;

  services.waybar.enable = true;
  services.waybar.package = pkgs.waybar.override {
    pulseSupport = true;
  };
  services.waybar.config = builtins.readFile ./configs/waybar.json;
  services.waybar.styles = builtins.readFile ./configs/waybar.css;

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
  };

  xresources.extraConfig = builtins.readFile ./configs/xresources.conf;
}
