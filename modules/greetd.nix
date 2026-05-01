_: {
  flake.modules.nixos.greetd =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${lib.getExe pkgs.cage} -s -- ${lib.getExe config.programs.regreet.package}";
            user = "greeter";
          };
        };
      };
    };
}
