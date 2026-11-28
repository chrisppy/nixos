_: {
  flake.modules.nixos.niri = {
    wrappers.niri.module.settings.animations = {
      workspace-switch.spring = _: {
        props = {
          damping-ratio = 1.0;
          stiffness = 1000;
          epsilon = 0.0001;
        };
      };
      window-open = {
        duration-ms = 120;
        curve = "ease-out-expo";
      };
      window-close = {
        duration-ms = 120;
        curve = "ease-out-quad";
      };
      horizontal-view-movement.spring = _: {
        props = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };
      window-movement.spring = _: {
        props = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };
      window-resize.spring = _: {
        props = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };
      config-notification-open-close.spring = _: {
        props = {
          damping-ratio = 0.6;
          stiffness = 1000;
          epsilon = 0.001;
        };
      };
      exit-confirmation-open-close.spring = _: {
        props = {
          damping-ratio = 0.6;
          stiffness = 500;
          epsilon = 0.01;
        };
      };
      screenshot-ui-open = {
        duration-ms = 200;
        curve = "ease-out-quad";
      };
      overview-open-close.spring = _: {
        props = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };
      recent-windows-close.spring = _: {
        props = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.001;
        };
      };
    };
  };
}
