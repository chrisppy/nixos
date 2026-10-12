_: {
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nil
        nixd
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
