_: {
  flake.modules.homeManager.dev =
    { lib, pkgs, ... }:
    {
      home.packages = with pkgs; [
        yaml-language-server
      ];

      programs.nhx.languages = {
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
}
