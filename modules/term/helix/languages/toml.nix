_: {
  flake.modules.homeManager.dev =
    { lib, pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          taplo
        ];
        languages = {
          language = [
            {
              name = "toml";
              auto-format = true;
              # Taplo is both the LSP and the formatter
              formatter = {
                command = lib.getExe pkgs.taplo;
                args = [
                  "fmt"
                  "-"
                ];
              };
            }
          ];

          language-server.taplo = {
            command = lib.getExe pkgs.taplo;
            args = [
              "lsp"
              "stdio"
            ];
          };
        };
      };
    };
}
