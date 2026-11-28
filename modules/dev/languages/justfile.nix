{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.pc =
    { pkgs, ... }:
    {
      users.users.${username}.packages = with pkgs; [
        just
      ];

      nhx.programs.nhx.languages = {
        language = [
          {
            name = "just";
            auto-format = true;
          }
        ];
      };
    };
}
