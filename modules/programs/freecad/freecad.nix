_: {
  flake.modules.nixos.design.programs.freecad = {
    enable = true;
    plugins = {
      fasteners = true;
      history = true;
      sheet-metal = true;
    };
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
}
