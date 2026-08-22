_: {
  flake.modules.homeManager.dev =
    { lib, pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          yaml-language-server
        ];
        languages = {
          language = [
            {
              name = "yaml";
              auto-format = true;
            }
          ];
          language-server = {
            yaml-language-server = {
              command = lib.getExe pkgs.yaml-language-server;
              args = [ "--stdio" ];
            };
          };
        };
      };
    };
}
