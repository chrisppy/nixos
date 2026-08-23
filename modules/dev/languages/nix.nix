{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      treefmt.programs = {
        deadnix = {
          enable = true;
          priority = 1;
        };

        statix = {
          enable = true;
          priority = 2;
        };

        nixf-diagnose = {
          enable = true;
          priority = 3;
        };

        nixfmt = {
          enable = true;
          package = inputs.nixfmt-rs.packages.${pkgs.stdenv.hostPlatform.system}.default;
          priority = 4;
        };
      };
    };

  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nil
        nixd
        inputs.nixfmt-rs.packages.${pkgs.stdenv.hostPlatform.system}.default

      ];

      programs.helix.languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = "nixfmt";
          }
        ];
      };
    };
}
