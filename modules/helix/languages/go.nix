_: {
  flake.modules.homeManager.dev =
    { lib, pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          go
          gopls
          gotools
        ];
        languages = {
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
    };
}
