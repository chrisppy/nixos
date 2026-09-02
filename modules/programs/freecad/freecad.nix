_: {
  flake.modules = {
    nixos.design =
      { pkgs, ... }:
      let
        # freecad = pkgs.callPackage ../pkgs/freecad/package.nix { };
        inherit (pkgs) freecad;

        fasteners = pkgs.fetchFromGitHub {
          owner = "shaise";
          repo = "FreeCAD_FastenersWB";
          rev = "last";
          hash = "sha256-mYg8M1APYtleQVgnVvGtpRQ/z90RvGK2v+FkHEBFfj0=";
        };
        history = pkgs.fetchFromGitHub {
          owner = "eblanshey";
          repo = "HistoryWorkbench";
          rev = "v0.1.0";
          hash = "sha256-kNUjmeaWRuo6n96Pt7mcUpISlpvVucgo47UJk7noq3I=";
        };
        sheet-metal = pkgs.fetchFromGitHub {
          owner = "shaise";
          repo = "FreeCAD_SheetMetal";
          rev = "Last";
          hash = "sha256-t03rARNxsAQSoSjkUdsjSF4UPkyElcHOAgEldjK00aA=";
        };

        freecad-customized = freecad.customize {
          modules = [
            fasteners
            history
            sheet-metal
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
          # userCfg = ./user.cfg;
        };
      in
      {
        environment.systemPackages = [ freecad-customized ];
      };
  };
}
