{ config, lib, pkgs, ... }:

# Thanks to https://www.reddit.com/r/NixOS/comments/ae9q01/how_to_os_from_inside_a_nix_file/ednqzap/
# echo "{ hostname = \"$(hostname)\"; operatingSystem = \"$(uname -s | awk '{ print $1 }' | sed 's/#.*-//')\"; }" > ~/.config/nixpkgs/machine.nix 
let
  machine = import ./machine.nix;
  isLinux = machine.operatingSystem == "Linux";
  isDarwin = machine.operatingSystem == "Darwin";
  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz;
  }) {
    doomPrivateDir = ./doom.d;  # Directory containing your config.el init.el
                                # and packages.el files
  };
in
{
  imports = [ ./waybar.nix ]
    ++ (if isDarwin then [ ./darwin.nix ] else [ ])
    ++ (if isLinux then [ ./linux.nix ] else [ ]);

  home.keyboard.layout = "gb";
  home.packages = [
    doom-emacs
    pkgs.aria2
    pkgs.awscli
    pkgs.aws-iam-authenticator
    pkgs.bat
    pkgs.bind
    pkgs.dejavu_fonts
    pkgs.docker-compose
    pkgs.fira-code
    pkgs.font-awesome
    pkgs.htop
    pkgs.ipafont
    pkgs.jq
    pkgs.kind
    pkgs.kubectl
    pkgs.maven
    pkgs.nixpkgs-fmt
    pkgs.ngrok
    pkgs.nodejs
    pkgs.rsync
    pkgs.whois
    pkgs.youtube-dl
  ];

  # These are required for non-NixOS installations
  home.sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";
  home.sessionVariables.EDITOR = "vim";
  home.sessionVariables.FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
  
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

  home.file.".emacs.d/init.el".text = ''
      (load "default.el")
  '';

  programs.git.enable = true;
  programs.git.userEmail = "jonjo@jonjomckay.com";
  programs.git.userName = "Jonjo McKay";
  programs.git.signing.key = "C4CC649D7F58611D";
  programs.git.signing.signByDefault = true;

  programs.gpg.enable = true;

  programs.kitty.enable = true;
  programs.kitty.font.name = "Fira Code Retina";
  programs.kitty.extraConfig = builtins.readFile ./configs/kitty.conf;

  programs.ssh.enable = true;
  programs.ssh.compression = true;
  programs.ssh.matchBlocks = {
    "jack" = {
      hostname = "jonjomckay.nsupdate.info";
      port = 2200;
      localForwards = [
        {
          bind.port = 6789;
          host.address = "localhost";
          host.port = 6789;
        }
        {
          bind.port = 7878;
          host.address = "localhost";
          host.port = 7878;
        }
        {
          bind.port = 8989;
          host.address = "localhost";
          host.port = 8989;
        }
        {
          bind.port = 9091;
          host.address = "localhost";
          host.port = 9091;
        }
      ];
    };
  };

  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;

  programs.vim.enable = true;

  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.initExtra = ''
    . "${pkgs.nix}/etc/profile.d/nix.sh"
  '';
  programs.zsh.shellAliases = {
    cat = "bat -pp";
  };
  programs.zsh.zplug.enable = true;
  programs.zsh.zplug.plugins = [
    {
      name = "zsh-users/zsh-syntax-highlighting";
      tags = [ "defer:2" ];
    }
  ];

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
