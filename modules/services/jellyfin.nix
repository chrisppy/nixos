{ config, inputs, ... }:
let
  inherit (config.flake.lib) mkVHost;
in
{
  flake.modules.nixos.jellyfin =
    { pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      # VA-API/QSV/OpenCL drivers come from the intel-arc module. sideling's
      # A310 (DG2) runs on i915; xe support for DG2 still needs force_probe.
      services = {
        jellyfin = {
          enable = true;
          package = unstable.jellyfin;
          openFirewall = true;
          hardwareAcceleration = {
            enable = true;
            type = "qsv";
            device = "/dev/dri/by-path/pci-0000:03:00.0-render";
          };
        };
        caddy.virtualHosts = mkVHost "media" 8096;
      };
    };
}
