{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules = {
    nixos.pc = {
      hardware.keyboard.qmk.enable = true;
    };
    homeManager.gui = {
      xdg = {
        enable = true;
        configFile."qmk/qmk.ini".text = ''
          [user]
          keyboard = crkbd/rev1
          keymap = ${username}
        '';
      };
    };
  };
}
