{ config, ... }:
let
  inherit (config.flake.modules.homeManager) noctalia;
in
{
  flake.modules = {
    homeManager.niri.imports = [
      noctalia
    ];
  };
}
