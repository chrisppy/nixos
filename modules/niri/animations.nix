_: {
  flake.modules.homeManager.niri = {
    programs.niri.settings.animations = {
      slowdown = 1.0;

      window-open = {
        spring = {
          damping-ratio = 0.8;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };

      window-close = {
        spring = {
          damping-ratio = 0.8;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };

      window-movement = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };

      window-resize = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };

      horizontal-view-movement = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };

      workspace-switch = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };

      config-notification-open-close = {
        spring = {
          damping-ratio = 0.6;
          stiffness = 1000;
          epsilon = 0.001;
        };
      };
    };
  };
}
