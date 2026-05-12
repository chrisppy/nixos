_: {
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          just
        ];
        languages = {
          language = [
            {
              name = "just";
              auto-format = true;
            }
          ];
        };
      };
    };
}
