{ inputs, ... }:
let
  inherit (inputs.base24-themes.lib) base24;
in
{
  flake.modules.nixos.base =
    { config, ... }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];

      fonts.fontconfig.enable = true;

      stylix = {
        enable = true;
        base16Scheme = builtins.toFile "${config.theme.name}.yaml" (base24.toYaml config.theme.scheme);
        polarity = config.theme.variant;
      };
    };
}
