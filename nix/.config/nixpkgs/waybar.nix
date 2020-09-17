{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.waybar;

  eitherStrBoolIntList = with types;
    either str (either bool (either int (listOf str)));

  configFile = pkgs.writeText "config"
    (builtins.toJSON cfg.extraConfig);

  stylesFile = pkgs.writeText "style.css"
    (cfg.styles);

in {
  options = {
    services.waybar = {
      enable = mkEnableOption "Waybar status bar";

      package = mkOption {
        type = types.package;
        default = pkgs.waybar;
        defaultText = literalExample "pkgs.waybar";
        description = "Waybar package to install.";
        example = literalExample ''
          pkgs.waybar.override {
            pulseSupport = true;
            swaySupport = true;
          }
        '';
      };

      extraConfig = mkOption {
        type = types.attrs;
        default = { };
        example = { layer = "top"; };
        description = ''
          JSON config that will override the default Waybar configuration.
        '';
      };

      styles = mkOption {
        type = types.lines;
        description = "Configuration for styles.";
        default = "";
        example = ''
          * {
            font-size: 20px;
            font-family: monospace;
          }

          window#waybar {
            background: #292b2e;
            color: #fdf6e3;
          }
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."waybar/config".source = configFile;
    xdg.configFile."waybar/style.css".source = stylesFile;

    systemd.user.services.waybar = {
      Unit = {
        Description = "Waybar status bar";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
        X-Restart-Triggers =
          [
            "${config.xdg.configFile."waybar/config".source}"
            "${config.xdg.configFile."waybar/style.css".source}"
          ];
      };

      Service = {
        Environment = "PATH=${cfg.package}/bin:/run/wrappers/bin";
        ExecStart = "${cfg.package}/bin/waybar";
        Restart = "on-failure";
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };

}
