{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.pc =
    { lib, pkgs, ... }:
    {
      users.users.${username}.packages = with pkgs; [
        taplo
      ];

      nhx.programs.nhx.languages = {
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
}
