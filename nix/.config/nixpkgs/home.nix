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
    pkgs.awscli
    pkgs.aws-iam-authenticator
    pkgs.docker-compose
    pkgs.kind
    pkgs.kubectl
    pkgs.nixpkgs-fmt
    pkgs.ngrok
    pkgs.youtube-dl
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file.".emacs.d/init.el".text = ''
      (load "default.el")
  '';

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
