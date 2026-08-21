_: {
  flake.modules = {
    nixos.design =
      { pkgs, ... }:
      let
        # freecad = pkgs.callPackage ../pkgs/freecad/package.nix { };
        inherit (pkgs) freecad;

        freecad-customized = freecad.customize {
          modules = [
            # fasteners
            # sheet-metal
          ];
          pythons = [
            (
              ps: with ps; [
                lxml
                requests
                pyjwt
                tzlocal
              ]
            )
          ];
          makeWrapperFlags = [
            "--set-default"
            "QT_FONT_DPI"
            "80"
          ];
          userCfg = ./user.cfg;
        };
      in
      {
        environment.systemPackages = [ freecad-customized ];
      };
  };
}
