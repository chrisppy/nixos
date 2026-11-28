{ config, ... }:
{
  # base < pc < niri: each profile builds on the one before it.
  flake.modules.nixos = {
    pc = {
      imports = [ config.flake.modules.nixos.base ];
      hardware.graphics.enable = true;
    };
    niri.imports = [ config.flake.modules.nixos.pc ];
  };
}
