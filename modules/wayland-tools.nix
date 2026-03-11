_: {
  flake.modules.homeManager.wayland = {pkgs, ...}: {
    home.packages = with pkgs; [
      brightnessctl
      grim
      slurp
      waypipe
      wev
      wl-clipboard
      wlr-randr
      wf-recorder
    ];
  };
}
