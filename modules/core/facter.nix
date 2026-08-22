_: {
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      hardware.facter.detected.dhcp.enable = false;
      environment.systemPackages = with pkgs; [
        nixos-facter
      ];
    };
}
