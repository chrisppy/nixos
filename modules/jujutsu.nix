{config, ...}: {
  flake.modules.homeManager.dev = {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          inherit (config.flake.meta.owner) email name;
        };
      };
    };
  };
}
