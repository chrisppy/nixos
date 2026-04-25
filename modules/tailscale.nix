{config, ...}: let
  inherit (config.flake.meta.owner) username;
in {
  flake.modules = {
    nixos.base = {config, ...}: {
      networking = {
        firewall = {
          trustedInterfaces = [
            config.services.tailscale.interfaceName
          ];
          allowedTCPPorts = [80 443];
        };
        nameservers = ["100.100.100.100"];
      };
      services.tailscale = let
        flags = [
          "--operator=${username}"
          "--accept-dns=true"
        ];
      in {
        enable = true;
        extraUpFlags = flags;
        extraSetFlags = flags;
        openFirewall = true;
        useRoutingFeatures = "both";
      };
    };
    homeManager.base = {
      lib,
      pkgs,
      ...
    }: {
      wayland.windowManager = {
        hyprland.settings.exec-once = [
          "${lib.getExe' pkgs.tailscale "tailscale"} systray"
        ];
        # niri.settings._children = [
        #   {
        #     spawn-at-startup = "${lib.getExe' pkgs.tailscale "tailscale"} systray";
        #   }
        # ];
      };
    };
  };
}
