_: {
  flake.modules.homeManager.dev =
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
