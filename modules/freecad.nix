_: {
  flake.modules.nixos.freecad = {pkgs, ...}: let
    fasteners = pkgs.fetchFromGitHub {
      owner = "shaise";
      repo = "FreeCAD_FastenersWB";
      rev = "last";
      hash = "sha256-mYg8M1APYtleQVgnVvGtpRQ/z90RvGK2v+FkHEBFfj0=";
    };
    sheet-metal = pkgs.fetchFromGitHub {
      owner = "shaise";
      repo = "FreeCAD_SheetMetal";
      rev = "Last";
      hash = "sha256-t03rARNxsAQSoSjkUdsjSF4UPkyElcHOAgEldjK00aA=";
    };

    freecad-customized = pkgs.freecad.customize {
      modules = [
        fasteners
        sheet-metal
      ];
      pythons = [
        (
          ps:
            with ps; [
              lxml
              requests
              pip
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
    };
  in {
    environment.systemPackages = [freecad-customized];
  };
}
