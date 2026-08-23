_: {
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        clippy
        rust-analyzer
        rustfmt
      ];

      programs.helix.languages = {
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
}
