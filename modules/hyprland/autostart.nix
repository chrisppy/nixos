_: {
  flake.modules.homeManager.hyprland = {pkgs, ...}: {
    wayland.windowManager.hyprland.settings.exec-once = [
      "${pkgs.discord}/bin/discord --start-minimized"
      "${pkgs.tailscale}/bin/tailscale systray"
    ];
  };
}
