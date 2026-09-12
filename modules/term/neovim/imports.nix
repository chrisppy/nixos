{ inputs, ... }:
{
  flake.modules.homeManager.base.imports = [
    inputs.nvf.homeManagerModules.default
  ];
}
