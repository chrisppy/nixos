{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.base =
    { lib, pkgs, ... }:
    {
      programs.fish = {
        enable = true;
        shellAliases = {
          open = lib.getExe' pkgs.xdg-utils "xdg-open";
          ns = lib.getExe pkgs.nix-search-cli;
          "nf." = "nix fmt .";

          h = "history";
          c = "clear";
          tree = "${lib.getExe pkgs.eza} --tree";

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
        interactiveShellInit = ''
          function gpa --description 'Pull all git repos in subdirectories'
            for d in */
              git -C $d pull
            end
          end
        '';
      };
      users.users.${username}.shell = pkgs.fish;

      # Plugins load from the system profile's vendor directories.
      environment.systemPackages = with pkgs.fishPlugins; [
        autopair
        done
      ];
    };
}
