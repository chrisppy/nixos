{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
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
        alejandra = {
          enable = true;
          priority = 4;
        };
        prettier.enable = true;
        shfmt.enable = true;
        taplo.enable = true;
      };
      settings = {
        on-unmatched = "fatal";
        global.excludes = [
          "LICENSE"
          ".git"
          ".gitattributes"
          ".gitignore"

          "*.jpg"
          "*.patch"
          "*.png"
          "*.svg"
          "**/.gitkeep"

          "secrets/**"
        ];
        formatter = {
          taplo.options = [
            "fmt"
            "-o"
            "align_entries=true"
            "-o"
            "reorder_keys=true"
          ];
        };
      };
    };
  };
}
