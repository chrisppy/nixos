{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
  dirs = {
    DESKTOP = "desktop";
    DOCUMENTS = "documents";
    DOWNLOAD = "downloads";
    MUSIC = "music";
    PICTURES = "pictures";
    PUBLICSHARE = "share";
    TEMPLATES = "templates";
    VIDEOS = "videos";
  };
in
{
  flake.modules.nixos.base =
    { lib, ... }:
    {
      home.files.".config/user-dirs.dirs" = builtins.toFile "user-dirs.dirs" (
        lib.concatLines (lib.mapAttrsToList (key: dir: ''XDG_${key}_DIR="$HOME/${dir}"'') dirs)
      );

      # Create the directories too, as Home Manager's xdg.userDirs did.
      systemd.user.tmpfiles.users.${username}.rules = lib.mapAttrsToList (
        _: dir: "d %h/${dir} - - - -"
      ) dirs;
    };
}
