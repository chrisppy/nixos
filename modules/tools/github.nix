{ config, ... }:
{
  flake.modules.nixos.pc =
    { pkgs, ... }:
    {
      users.users.${config.flake.meta.owner.username}.packages = [ pkgs.gh ];

      # gh writes hosts.yml (the login) next to config.yml, so link the file
      # rather than pointing GH_CONFIG_DIR at the store.
      home.files.".config/gh/config.yml" = (pkgs.formats.yaml { }).generate "gh-config.yml" {
        version = 1;
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
        editor = "hx";
        git_protocol = "ssh";
      };
    };
}
