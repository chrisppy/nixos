{ inputs, ... }:
{
  flake.modules.homeManager.base.imports = [
    inputs.nhx.homeManagerModules.nhx
  ];
}
