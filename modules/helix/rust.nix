_: {
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          clippy
          rust-analyzer
          rustfmt
        ];
        languages = {
          language = [
            {
              name = "rust";
              auto-format = true;
            }
          ];
          language-server = {
            rust-analyzer.config.rust-analyzer.config = {
              checkOnSave = {
                command = "clippy"; # Uses clippy instead of cargo check
              };
              cargo = {
                allFeatures = true;
              };
              procMacro = {
                enable = true;
              };
            };
          };
        };
      };
    };
}
