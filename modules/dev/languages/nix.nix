{ inputs, ... }:
{
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nil
        nixd
        inputs.nixfmt-rs.packages.${pkgs.stdenv.hostPlatform.system}.default

      ];

      programs.nhx.languages = {
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
