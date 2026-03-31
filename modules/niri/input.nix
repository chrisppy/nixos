_: {
  flake.modules.homeManager.niri = {
    programs.niri.settings.input = {
      keyboard.xkb = {};
      mouse = {
        accel-speed = 0.0;
        accel-profile = "flat";
      };
      focus-follows-mouse.enable = true;
      warp-mouse-to-focus = false;
    };
  };
}
