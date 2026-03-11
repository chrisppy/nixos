_: {
  flake.modules.homeManager = {
    base = {pkgs, ...}: {
      home.packages = with pkgs; [
        kitty.terminfo
      ];
    };
    gui = {
      programs.kitty = {
        enable = true;
        enableGitIntegration = true;
      };
    };
  };
}
