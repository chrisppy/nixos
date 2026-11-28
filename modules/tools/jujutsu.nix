{ config, ... }:
{
  flake.modules.nixos.pc.wrappers.jujutsu.module.settings.user = {
    inherit (config.flake.meta.owner) email name;
  };
}
