_: {
  perSystem.treefmt = {
    programs.taplo.enable = true;

    settings.formatter.taplo.options = [
      "fmt"
      "-o"
      "align_entries=true"
      "-o"
      "reorder_keys=true"
    ];
  };

  flake.modules.homeManager.dev =
    { lib, pkgs, ... }:
    {
      home.packages = with pkgs; [
        taplo
      ];

      programs.nhx.languages = {
        language = [
          {
            name = "toml";
            auto-format = true;
            # Taplo is both the LSP and the formatter
            formatter = {
              command = lib.getExe pkgs.taplo;
              args = [
                "fmt"
                "-"
              ];
            };
          }
        ];

        language-server.taplo = {
          command = lib.getExe pkgs.taplo;
          args = [
            "lsp"
            "stdio"
          ];
        };
      };
    };
}
