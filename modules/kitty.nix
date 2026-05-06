_: {
  flake.modules.homeManager = {
    base =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          kitty.terminfo
        ];
      };
    gui =
      {
        pkgs,
        ...
      }:
      {
        programs.kitty.enable = true;
        home.packages = [ pkgs.xterm ];
      };
  };
}
