{config, ...}: {
  flake.modules = {
    homeManager.hyprland.imports = [
      config.flake.modules.homeManager.noctalia
    ];
  };
}
