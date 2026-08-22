_: {
  flake.modules.homeManager.dev =
    { lib, pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          ltex-ls
          marksman
        ];
        languages = {
          language = [
            {
              name = "markdown";
              language-servers = [
                "marksman"
                "ltex-ls"
              ];
              auto-format = true;
            }
          ];
          language-server = {
            marksman = {
              command = lib.getExe pkgs.marksman;
              args = [ "server" ];
            };
            ltex-ls = {
              command = lib.getExe pkgs.ltex-ls;
            };
          };
        };
      };
    };
}
