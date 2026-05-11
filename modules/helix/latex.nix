_: {
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          texlab
          texlive.combined.scheme-small
          zathura
        ];
        languages = {
          language = [
            {
              name = "latex";
              auto-format = true;
              language-servers = [ "texlab" ];
            }
          ];

          language-server.texlab.config.texlab = {
            build = {
              # Use latexmk for automatic dependency management
              executable = "latexmk";
              args = [
                "-pdf"
                "-interaction=nonstopmode"
                "-synctex=1"
                "%f"
              ];
              onSave = true;
            };
            forwardSearch = {
              # Example: Opens the PDF in Zathura at the correct line
              executable = "zathura";
              args = [
                "--synctex-forward"
                "%l:1:%f"
                "%p"
              ];
            };
          };
        };
      };
    };
}
