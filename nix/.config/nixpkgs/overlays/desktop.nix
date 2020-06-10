self: super: {
  desktop = self.buildEnv {
    name = "desktop";

    paths = with self.pkgs; [
      # Nothing yet
    ];
  };
}
