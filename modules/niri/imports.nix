{
  inputs,
  config,
  ...
}: {
  flake.modules = {
    nixos.niri.imports = [inputs.niri-module.nixosModules.niri];

    homeManager.niri.imports = [
      inputs.niri-module.homeModules.niri
      config.flake.modules.homeManager.noctalia
    ];
  };
}
