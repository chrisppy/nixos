{ config, ... }:
{
  flake.modules = {
    nixos.base = {
      users = {
        users.${config.username}.isNormalUser = true;
        groups = {
          wheel.members = [ config.username ];
          "systemd-journal".members = [ config.username ];
        };
      };
    };
  };
}
