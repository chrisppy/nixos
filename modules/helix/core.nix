_: {
  flake.modules.homeManager.base =
    { pkgs, ... }:
    let
      inherit (pkgs) helix;
    in
    {
      programs.helix = {
        enable = true;
        package = helix;
        defaultEditor = true;
      };
    };
}
