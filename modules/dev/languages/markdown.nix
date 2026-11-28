{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.pc =
    { lib, pkgs, ... }:
    {
      users.users.${username}.packages = with pkgs; [
        ltex-ls
        marksman
      ];

      nhx.programs.nhx.languages = {
        language = [
          {
            name = "markdown";
            language-servers = [
              "marksman"
              "ltex-ls"
            ];
            auto-format = true;
          }
        ];

        language-server = {
          marksman = {
            command = lib.getExe pkgs.marksman;
            args = [ "server" ];
          };
          ltex-ls = {
            command = lib.getExe pkgs.ltex-ls;
          };
        };
      };
    };
}
