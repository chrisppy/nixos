{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.pc =
    { pkgs, ... }:
    {
      users.users.${username}.packages = with pkgs; [
        clippy
        rust-analyzer
        rustfmt
      ];

      nhx.programs.nhx.languages = {
        language = [
          {
            name = "rust";
            auto-format = true;
          }
        ];

        language-server = {
          rust-analyzer.config.rust-analyzer = {
            checkOnSave.command = "clippy";
            cargo.allFeatures = true;
            procMacro.enable = true;
          };
        };
      };
    };
}
