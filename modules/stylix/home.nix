{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  # What Stylix's Home Manager targets did that its NixOS ones don't: the
  # cursor for the session, and Home Manager integration turned off.
  flake.modules.nixos.base =
    { config, ... }:
    let
      inherit (config.stylix) cursor;
    in
    {
      stylix.homeManagerIntegration = {
        autoImport = false;
        followSystem = false;
      };

      users.users.${username}.packages = [ cursor.package ];
      environment.sessionVariables = {
        XCURSOR_THEME = cursor.name;
        XCURSOR_SIZE = toString cursor.size;
      };
    };
}
