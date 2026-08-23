_: {
  flake.modules.homeManager.dev =
    { lib, pkgs, ... }:
    {
      home.packages = with pkgs; [
        go
        gopls
        gotools
      ];

      programs.nhx.languages = {
        language = [
          {
            name = "go";
            auto-format = true;
            formatter = {
              command = lib.getExe' pkgs.gotools "goimports";
            };
          }
        ];

        language-server.gopls = {
          command = lib.getExe pkgs.gopls;
          config = {
            # Advanced gopls settings
            hints = {
              assignVariableTypes = true;
              compositeLiteralFields = true;
              parameterNames = true;
            };
            analyses = {
              unusedparams = true;
              shadow = true;
            };
            staticcheck = true;
          };
        };
      };
    };
}
