{config, ...}: let
  inherit (config.flake.meta.owner) username;
in {
  flake.modules = {
    nixos.base = {config, ...}: {
      networking.firewall.trustedInterfaces = [
        config.services.tailscale.interfaceName
      ];
      services.tailscale = let
        flags = ["--operator=${username}"];
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
      wayland.windowManager.hyprland.settings.exec-once = [
        "${lib.getExe' pkgs.tailscale "tailscale"} systray"
      ];

      programs.niri.settings.spawn-at-startup = [
        {command = ["${lib.getExe' pkgs.tailscale "tailscale"}" "systray"];}
      ];
    };
  };
}
