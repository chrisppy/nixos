{ inputs, ... }: {
  flake.modules = {
    nixos.greetd =
      { pkgs, ... }:
      {
        imports = [ inputs.birdland.nixosModules.default ];

        programs.birdland.gate = {
          enable = true;
          wallpaper = inputs.self + "/assets";
          theme.scheme = "birdland";
          font = {
            family = "Inter";
            package = pkgs.inter;
          };
        };
      };
    nixos.niri =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        apps = [
          "announcer"
          "bullpen"
          "dugout"
          "jumbotron"
          "lineup"
          "outfield"
          "tarp"
        ];

        # The Home Manager module's settings, given to every app's wrapper.
        settings = {
          theme.scheme = "birdland";
          font = {
            family = "Inter";
            package = pkgs.inter;
          };

          bullpen = {
            position = "top";
            units = "imperial";
            clock.format = "HH:mm";
            date.format = "MMM dd";
            feeds.command = "${lib.getExe config.wrappers.kitty.package} --class pressbox -e pressbox";
            weather = {
              latitude = 39.41;
              longitude = -77.29;
            };
            layout = {
              left = [
                "workspaces"
                "title"
              ];
              center = [
                "dnd"
                "feeds"
                "date"
                "clock"
                "weather"
                "idle-inhibitor"
              ];
              right = [
                "tray"
                [
                  "volume"
                  "microphone"
                ]
                [
                  "network"
                  "battery"
                  "temperature"
                  "cpu"
                  "memory"
                  "gpu"
                ]
              ];
            };
          };

          lineup = {
            iconSize = 24;
            position = "bottom";
            favorites = [
              "freecad"
              "chromium-browser"
            ];
          };

          jumbotron.position = "top";

          outfield = {
            enable = true; # tarp uses outfield's wallpaper when it's enabled
            wallpaper = inputs.self + "/assets";
            interval = 30;
            shuffle = true;
          };

          announcer.position = "top-right";
        };

        tarp = lib.getExe config.wrappers.tarp.package;
        # As the Home Manager module's swayidle setup: lock, then wait until
        # tarp confirms every monitor is covered.
        tarpLock = pkgs.writeShellScript "birdland-tarp-lock" ''
          "${tarp}" ipc call tarp lock
          for _ in {1..50}; do
            [ "$("${tarp}" ipc call tarp isSecure)" = true ] && exit 0
            ${pkgs.coreutils}/bin/sleep 0.1
          done
          echo "birdland-tarp-lock: the lock screen did not confirm the lock" >&2
          exit 1
        '';
      in
      {
        wrappers = lib.genAttrs apps (_: {
          module = { inherit settings; };
        });

        fonts.packages = [
          pkgs.inter
          pkgs.nerd-fonts.symbols-only
        ];

        # What programs.birdland.systemd.enable set up, per app.
        systemd.user.services =
          lib.genAttrs apps (name: {
            description = "Birdland ${name}";
            partOf = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            wantedBy = [ "graphical-session.target" ];
            unitConfig = {
              ConditionEnvironment = "WAYLAND_DISPLAY";
            }
            // lib.optionalAttrs (name == "tarp") {
              # A lock screen that stays down leaves the session locked.
              StartLimitIntervalSec = 0;
            };
            serviceConfig = {
              ExecStart = lib.getExe config.wrappers.${name}.package;
              Restart = "always";
              RestartSec = if name == "tarp" then 1 else 3;
            };
          })
          // {
            # Lock after 10 minutes, turn the screens off after 15, and lock
            # before sleep and on `loginctl lock-session`.
            swayidle = {
              description = "Idle manager (locks with Birdland tarp)";
              partOf = [ "graphical-session.target" ];
              after = [ "graphical-session.target" ];
              wantedBy = [ "graphical-session.target" ];
              unitConfig.ConditionEnvironment = "WAYLAND_DISPLAY";
              serviceConfig = {
                ExecStart = lib.escapeShellArgs [
                  (lib.getExe pkgs.swayidle)
                  "-w"
                  "timeout"
                  "600"
                  "${tarpLock}"
                  "timeout"
                  "900"
                  "${tarp} ipc call tarp screenOff"
                  "before-sleep"
                  "${tarpLock}"
                  "lock"
                  "${tarpLock}"
                ];
                Restart = "always";
              };
            };
          };
      };
  };
}
