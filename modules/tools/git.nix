{ config, ... }:
let
  inherit (config.flake.meta.owner) email name;
in
{
  # System-wide /etc/gitconfig instead of ~/.config/git/config.
  flake.modules.nixos.pc =
    { pkgs, ... }:
    {
      programs.git = {
        enable = true;
        config = {
          user = { inherit email name; };
          alias = {
            fuckit = "reset --hard";
            lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
            tasks = "grep -EI \"TODO|FIXME|HACK|OPTIMIZE|NOTE|BUG\"";
          };
          commit.verbose = "yes";
          core = {
            editor = "hx";
            excludesFile = "${pkgs.writeText "gitignore" "tags\n"}";
          };
          init.defaultBranch = "master";
          pull.rebase = true;
          push = {
            default = "simple";
            autoSetupRemote = true;
          };
        };
      };
    };
}
