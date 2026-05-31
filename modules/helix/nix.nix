{ inputs, ... }:
{
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          nil
          nixd
          inputs.nixfmt-rs.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
        languages = {
          language = [
            {
              name = "nix";
              auto-format = true;
              formatter.command = "nixfmt";
            }
          ];
        };
      };
    };
}
