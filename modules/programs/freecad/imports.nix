{ inputs, ... }: {
  flake.modules.nixos.design.imports = [
    inputs.freecad-flake.flakeModules.default
  ];
}
