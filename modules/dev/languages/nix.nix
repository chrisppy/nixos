{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.pc =
    { pkgs, ... }:
    {
      users.users.${username}.packages = with pkgs; [
        nil
        nixd
        nixfmt
      ];

      nhx.programs.nhx.languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = "nixfmt";
          }
        ];
      };
    };
}
