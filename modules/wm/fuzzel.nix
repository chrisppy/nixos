_: {
  flake.modules.homeManager.fuzzel =
    {
      config,
      lib,
      ...
    }:
    {
      programs.fuzzel = {
        enable = true;
        settings = {
          main = {
            terminal = "${lib.getExe config.programs.kitty.package}";
          };
        };
      };
    };
}
