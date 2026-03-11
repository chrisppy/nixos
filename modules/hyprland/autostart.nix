_: {
  flake.modules.homeManager.hyprland = {lib, pkgs, ...}: {
    wayland.windowManager.hyprland.settings.exec-once = [
      "${lib.getExe pkgs.discord} --start-minimized"
      "${lib.getExe pkgs.tailscale} systray"
    ];
  };
}
