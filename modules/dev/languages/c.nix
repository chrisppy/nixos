_: {
  flake.modules.homeManager.dev =
    { lib, pkgs, ... }:
    {
      home.packages = with pkgs; [
        clang
        clang-tools
        gdb
      ];

      programs.nhx.languages = {
        language = [
          {
            name = "c";
            auto-format = true;
          }
          {
            name = "cpp";
            auto-format = true;
          }
        ];

        language-server = {
          clangd.command = lib.getExe' pkgs.clang-tools "clangd";
        };
      };
    };
}
