_: {
  flake.modules.homeManager.niri = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkDefault mkIf;
  in {
    options.stylix.targets.niri.enable = config.lib.stylix.mkEnableTarget "niri" true;

    config = mkIf (config.stylix.enable && config.stylix.targets.niri.enable) {
      programs.niri.settings = {
        cursor = mkIf (config.stylix.cursor != null) {
          size = mkDefault config.stylix.cursor.size;
          theme = mkDefault config.stylix.cursor.name;
        };
        layout = {
          focus-ring = {
            on = {};
          };
          border = with config.lib.stylix.colors.withHashtag; {
            on = {};
            active.color = base0D;
            inactive.color = base03;
          };
        };
      };
    };
  };
}
