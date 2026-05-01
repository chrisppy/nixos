{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules = {
    nixos.base =
      { pkgs, ... }:
      {
        programs.fish.enable = true;
        users.users.${username}.shell = pkgs.fish;
      };
    homeManager.base =
      {
        lib,
        pkgs,
        ...
      }:
      {
        programs.fish = {
          enable = true;
          shellAliases = {
            open = lib.getExe' pkgs.xdg-utils "xdg-open";
            ns = lib.getExe pkgs.nix-search-cli;
            "nf." = "nix fmt .";

            h = "history";
            c = "clear";

            # Git
            gs = "git status";
            ga = "git add";
            "ga." = "git add .";
            gch = "git checkout";
            gchb = "git checkout -b";
            gc = "git commit -s";
            gcm = "git commit -sm";
            gca = "git commit -sam";
            gb = "git branch";
            gp = "git push";
            gpl = "git pull";
          };
          functions = {
            gpa = {
              description = "Pull all git repos in subdirectories";
              body = ''
                for d in */
                  git -C $d pull
                end
              '';
            };
          };
          plugins = [
            {
              name = "autopair";
              inherit (pkgs.fishPlugins.autopair) src;
            }
            {
              name = "done";
              inherit (pkgs.fishPlugins.done) src;
            }
          ];
        };
      };
  };
}
