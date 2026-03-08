{config, ...}: {
  flake.modules.homeManager.dev = {
    programs.git = {
      enable = true;
      ignores = ["tags"];
      settings = {
        user = {
          inherit (config.flake.meta.owner) email name;
        };
        alias = {
          fuckit = "reset --hard";
          lg = "log --color --graphs --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
          tasks = "grep -EI \"TODO|FIXME|HACK|OPTIMIZE|NOTE|BUG\"";
        };
        commit.verbose = "yes";
        core.editor = "hx";
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
