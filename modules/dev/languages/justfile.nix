_: {
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        just
      ];

      programs.nhx.languages = {
        language = [
          {
            name = "just";
            auto-format = true;
          }
        ];
      };
    };
}
