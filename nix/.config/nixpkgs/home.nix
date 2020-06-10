{ config, lib, pkgs, ... }:

{
  home.keyboard.layout = "gb";
  home.packages = [
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

  services.syncthing.enable = true;

  xsession.enable = true;
  xsession.scriptPath = ".hm-xsession";
  xsession.windowManager.i3.enable = true;
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
  xsession.windowManager.i3.config.gaps.smartGaps = true;
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
