_: {
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.helix = {
        enable = true;
        package = pkgs.steelix;
        defaultEditor = true;
      };
    };
}
