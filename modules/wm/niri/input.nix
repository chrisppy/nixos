_: {
  flake.modules.nixos.niri = {
    wrappers.niri.module.settings.input = {
      keyboard.xkb = _: { };
      mouse = {
        accel-speed = 0.0;
        accel-profile = "flat";
      };
      focus-follows-mouse = _: { };
      warp-mouse-to-focus = _: { };
    };
  };
}
