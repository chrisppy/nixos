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
            rust-analyzer.config.rust-analyzer = {
              checkOnSave.command = "clippy";
              cargo.allFeatures = true;
              procMacro.enable = true;
            };
          };
        };
      };
    };
}
