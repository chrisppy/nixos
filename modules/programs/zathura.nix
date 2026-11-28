{ inputs, ... }:
{
  flake.modules.nixos.pc =
    { config, ... }:
    {
      wrappers.zathura.module = {
        imports = [ inputs.base24-themes.wrapperModules.zathura ];
        base24 = {
          theme = config.theme.name;
          opacity = config.stylix.opacity.applications;
        };
      };
    };
}
