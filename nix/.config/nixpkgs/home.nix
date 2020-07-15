{ config, lib, pkgs, ... }:

{
  imports = [ ./waybar.nix ];

  home.keyboard.layout = "gb";
  home.packages = [
    pkgs.aria2
    pkgs.awscli
    pkgs.aws-iam-authenticator
    pkgs.bat
    pkgs.bind
    pkgs.blueman
    pkgs.bmon
    pkgs.chromium
    pkgs.dejavu_fonts
    pkgs.docker-compose
    pkgs.fira-code
    pkgs.font-awesome
    pkgs.gnome3.gnome-calculator
    pkgs.gnome3.gnome-screenshot
    pkgs.htop
    pkgs.iotop
    pkgs.ipafont
    pkgs.jq
    pkgs.keepassxc
    pkgs.kind
    pkgs.maven
    pkgs.meld
    pkgs.networkmanager-openvpn
    pkgs.ngrok
    pkgs.nodejs
    pkgs.pavucontrol
    pkgs.python38
    pkgs.python38Packages.i3ipc
    pkgs.rsync
    pkgs.slack
    pkgs.sublime3-dev
    pkgs.vscodium
    pkgs.whois
    pkgs.youtube-dl
    pkgs.zoom-us
  ];

  # These are required for non-NixOS installations
  home.sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";
  home.sessionVariables.FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
  home.sessionVariables.LD_LIBRARY_PATH = "$(nixGL printenv LD_LIBRARY_PATH):$LD_LIBRARY_PATH";
  home.sessionVariables.LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  home.sessionVariables.XDG_DATA_DIRS = "$HOME/.nix-profile/share:$HOME/.share:$XDG_DATA_DIRS:-/usr/local/share/:/usr/share";

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    colors = {
      primary = {
        background = "#1d1f21";
        foreground = "#c5c8c6";
      };

      cursor = {
        cursor = "#c5c8c6";
      };

      normal = {
        black = "#1d1f21";
        red = "#f393d4";
        green = "#82f8b8";
        yellow = "#fff9b2";
        blue = "#3592f4";
        magenta = "#ea60f3";
        cyan = "#67d5fa";
        white = "#c5c8c6";
      };

      bright = {
        black = "#969896";
        red = "#ee7bca";
        green = "#74faa9";
        yellow = "#fffaa3";
        blue = "#2b7bf1";
        magenta = "#e23df0";
        cyan = "#58cbf9";
        white = "#ffffff";
      };
    };

    env = {
      TERM = "xterm-256color";
    };

    font = {
      size = 9;

      normal = {
        family = "Fira Code Retina";
      };
    };

    scrolling = {
      history = 100000;
    };

    window = {
      padding = {
        x = 10;
        y = 10;
      };
    };
  };

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
  programs.kitty.font.name = "Fira Code Retina";
  programs.kitty.extraConfig = builtins.readFile ./configs/kitty.conf;

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

  xresources.extraConfig = builtins.readFile ./configs/xresources.conf;

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
  wayland.windowManager.sway.config.terminal = "nixGL alacritty";
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
