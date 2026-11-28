{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.pc =
    { lib, pkgs, ... }:
    {
      users.users.${username}.packages = with pkgs; [
        yaml-language-server
      ];

      nhx.programs.nhx.languages = {
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
