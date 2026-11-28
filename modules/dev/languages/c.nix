{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.pc =
    { lib, pkgs, ... }:
    {
      users.users.${username}.packages = with pkgs; [
        clang
        clang-tools
        gdb
      ];

      nhx.programs.nhx.languages = {
        language = [
          {
            name = "c";
            auto-format = true;
          }
          {
            name = "cpp";
            auto-format = true;
          }
        ];

        language-server = {
          clangd.command = lib.getExe' pkgs.clang-tools "clangd";
        };
      };
    };
}
