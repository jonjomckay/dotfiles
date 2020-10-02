{ config, lib, pkgs, ... }:

{
  # home.packages = [
  #   pkgs.gnome3.gnome-calculator
  #   pkgs.meld
  #   pkgs.networkmanager-openvpn
  #   pkgs.pulsemixer
  #   pkgs.slack
  #   pkgs.xdg-user-dirs
  # ];

  # home.sessionVariables.LD_LIBRARY_PATH = "$(nixGL printenv LD_LIBRARY_PATH):$LD_LIBRARY_PATH";
  # home.sessionVariables.LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  # # This is only required because the gnome-keyring service doesn't seem to set it properly yet
  # # home.sessionVariables.SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";

  # accounts.email.accounts = {
  #   "test@example.com" = {
  #     address = "test@example.com";

  #     folders.inbox = "";

  #     neomutt = {
  #       enable = true;
  #       sendMailCommand = "/bin/true";
  #     };

  #     passwordCommand = "/bin/true";
  #     primary = true;
  #     realName = "Jonjo McKay";
  #   };
  # };
  # accounts.email.maildirBasePath = "tmp/maildir";

  # programs.neomutt.enable = true;
  # programs.neomutt.sidebar.enable = true;

  # services.mpd.enable = true;
  # services.mpd.musicDirectory = "/mnt/music";

  # xresources.extraConfig = builtins.readFile ./configs/xresources.conf;
}
