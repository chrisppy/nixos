{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.pc = {
    hardware.keyboard.qmk.enable = true;

    home.files.".config/qmk/qmk.ini" = builtins.toFile "qmk.ini" ''
      [user]
      keyboard = crkbd/rev1
      keymap = ${username}
    '';
  };
}
