_: {
  flake.modules.homeManager.base = {pkgs, ...}: {
    programs.eza = {
      enable = true;
      package = pkgs.eza;
    };
  };
}
