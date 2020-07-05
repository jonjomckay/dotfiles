{ config, pkgs, python, ... }:

{
  # Include configuration common to all installations
  imports = [ ./configuration.nix ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/5e6824c6-a4c9-4e7b-81cf-e383913c1dd7";
      preLVM = true;
      allowDiscards = true;
    };
  };

  networking.hostName = "grizz";
  networking.interfaces.enp7s0.useDHCP = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

